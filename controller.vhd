library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.const_package.all;

entity controller is
  port (
    in_Opcode    : in  std_logic_vector(5 downto 0);
    in_Funct     : in  std_logic_vector(5 downto 0);
    out_RegDst   : out std_logic;
    out_Branch   : out std_logic;
    out_MemRead  : out std_logic;
    out_MemWrite : out std_logic;
    out_ALUOp    : out std_logic_vector(3 downto 0);
    out_MemtoReg : out std_logic;
    out_ALUSrc   : out std_logic;
    out_RegWrite : out std_logic;
    out_Jump     : out std_logic
    );
end controller;

architecture behavioral of controller is
begin

  UpdateOutputs : process (in_Opcode, in_Funct)
  begin

    case in_Opcode is

      -------------------------------------------------------------------------
      -- R-Type Instructions.
      -------------------------------------------------------------------------
      when OP_R_TYPE =>

        out_RegDST   <= '1';
        out_Branch   <= '0';
        out_MemRead  <= '0';
        out_MemWrite <= '0';
        out_MemtoReg <= '0';
        out_ALUSrc   <= '0';
        out_RegWrite <= '1';
        out_Jump     <= '0';
        
        case in_Funct is
          when FUNCT_ADD  => out_ALUOp <= ALU_ADD;
          when FUNCT_AND  => out_ALUOp <= ALU_AND;
          when FUNCT_NOR  => out_ALUOp <= ALU_NOR;
          when FUNCT_OR   => out_ALUOp <= ALU_OR;
          when FUNCT_SLT  => out_ALUOp <= ALU_SLT;
          when FUNCT_SLTU => out_ALUOp <= ALU_SLTU;
          when FUNCT_SLL  => out_ALUOp <= ALU_SLL;
          when FUNCT_SUB  => out_ALUOp <= ALU_SUB;
          when FUNCT_JR =>
            out_RegDST   <= '0';
            out_Branch   <= '0';
            out_MemRead  <= '0';
            out_MemWrite <= '0';
            out_ALUOp    <= ALU_JR;
            out_MemtoReg <= '0';
            out_ALUSrc   <= '0';
            out_RegWrite <= '0';
            out_Jump     <= '1';
          when others => out_ALUOp <= ALU_NOP;
        end case;

        -------------------------------------------------------------------------
        -- OP Immediate.
        -------------------------------------------------------------------------
      when OP_ADDI =>
        out_RegDST   <= '0';
        out_Branch   <= '0';
        out_MemRead  <= '0';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_ADD;
        out_MemtoReg <= '0';
        out_ALUSrc   <= '1';
        out_RegWrite <= '1';
        out_Jump     <= '0';

      when OP_ANDI =>
        out_RegDST   <= '0';
        out_Branch   <= '0';
        out_MemRead  <= '0';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_AND;
        out_MemtoReg <= '0';
        out_ALUSrc   <= '1';
        out_RegWrite <= '1';
        out_Jump     <= '0';

      when OP_ORI =>
        out_RegDST   <= '0';
        out_Branch   <= '0';
        out_MemRead  <= '0';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_OR;
        out_MemtoReg <= '0';
        out_ALUSrc   <= '1';
        out_RegWrite <= '1';
        out_Jump     <= '0';

        -------------------------------------------------------------------------
        -- Set.
        -------------------------------------------------------------------------
      when OP_SLTI =>
        out_RegDST   <= '1';
        out_Branch   <= '0';
        out_MemRead  <= '0';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_SLTI;
        out_MemtoReg <= '0';
        out_ALUSrc   <= '1';
        out_RegWrite <= '1';
        out_Jump     <= '0';
        
      when OP_SLTIU =>
        out_RegDST   <= '1';
        out_Branch   <= '0';
        out_MemRead  <= '0';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_SLTIU;
        out_MemtoReg <= '0';
        out_ALUSrc   <= '1';
        out_RegWrite <= '1';
        out_Jump     <= '0';

        -------------------------------------------------------------------------
        -- Branch.
        -------------------------------------------------------------------------
      when OP_BEQ | OP_BNE =>
        out_RegDST   <= '0';
        out_Branch   <= '1';
        out_MemRead  <= '0';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_SUB;
        out_MemtoReg <= '0';
        out_ALUSrc   <= '0';
        out_RegWrite <= '0';
        out_Jump     <= '0';

        -------------------------------------------------------------------------
        -- Load Instructions.
        -------------------------------------------------------------------------
      when OP_LW =>
        out_RegDST   <= '0';
        out_Branch   <= '0';
        out_MemRead  <= '1';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_ADD;
        out_MemtoReg <= '1';
        out_ALUSrc   <= '1';
        out_RegWrite <= '1';
        out_Jump     <= '0';

      when OP_LB =>
        out_RegDST   <= '0';
        out_Branch   <= '0';
        out_MemRead  <= '1';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_ADD;
        out_MemtoReg <= '1';
        out_ALUSrc   <= '1';
        out_RegWrite <= '1';
        out_Jump     <= '0';

      when OP_LBU =>
        out_RegDST   <= '0';
        out_Branch   <= '0';
        out_MemRead  <= '1';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_ADD;
        out_MemtoReg <= '1';
        out_ALUSrc   <= '1';
        out_RegWrite <= '1';
        out_Jump     <= '0';

      when OP_LUI =>
        out_RegDST   <= '0';
        out_Branch   <= '0';
        out_MemRead  <= '0';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_LUI;
        out_MemtoReg <= '0';
        out_ALUSrc   <= '0';
        out_RegWrite <= '1';
        out_Jump     <= '0';

        -------------------------------------------------------------------------
        -- Store Word.
        -------------------------------------------------------------------------
      when OP_SW =>
        out_RegDST   <= '0';
        out_Branch   <= '0';
        out_MemRead  <= '0';
        out_MemWrite <= '1';
        out_ALUOp    <= ALU_ADD;
        out_MemtoReg <= '0';
        out_ALUSrc   <= '1';
        out_RegWrite <= '0';
        out_Jump     <= '0';

        -------------------------------------------------------------------------
        -- Jump.
        -------------------------------------------------------------------------
      when OP_J =>
        out_RegDST   <= '0';
        out_Branch   <= '0';
        out_MemRead  <= '0';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_NOP;
        out_MemtoReg <= '0';
        out_ALUSrc   <= '0';
        out_RegWrite <= '0';
        out_Jump     <= '1';

      when OP_JAL =>
        out_RegDST   <= '0';
        out_Branch   <= '0';
        out_MemRead  <= '0';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_NOP;
        out_MemtoReg <= '0';
        out_ALUSrc   <= '0';
        out_RegWrite <= '0';
--        out_RegWrite <= '1';
        out_Jump     <= '1';

        -------------------------------------------------------------------------
        -- Default.
        -------------------------------------------------------------------------
      when others =>
        out_RegDST   <= '0';
        out_Branch   <= '0';
        out_MemRead  <= '0';
        out_MemWrite <= '0';
        out_ALUOp    <= ALU_NOP;
        out_MemtoReg <= '0';
        out_ALUSrc   <= '0';
        out_RegWrite <= '0';
        out_Jump     <= '0';
        
    end case;
    
  end process UpdateOutputs;

end behavioral;
