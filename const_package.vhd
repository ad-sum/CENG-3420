library IEEE;
use IEEE.std_logic_1164.all;

package const_package is
  -----------------------------------------------------------------------------
  -- PC and Instruction constants.
  -----------------------------------------------------------------------------
  constant PC_Initial        : std_logic_vector(31 downto 0) := X"00004000";
  constant Final_Instruction : std_logic_vector(31 downto 0) := X"00000000";
  constant Reg_31            : std_logic_vector(4 downto 0) := "11111";

  -----------------------------------------------------------------------------
  -- Operation codes.
  -----------------------------------------------------------------------------
  constant OP_R_TYPE : std_logic_vector(5 downto 0) := "000000";
  constant OP_ADDI   : std_logic_vector(5 downto 0) := "001000";
  constant OP_ADDIU  : std_logic_vector(5 downto 0) := "001001";
  constant OP_ANDI   : std_logic_vector(5 downto 0) := "001100";
  constant OP_BEQ    : std_logic_vector(5 downto 0) := "000100";
  constant OP_BNE    : std_logic_vector(5 downto 0) := "000101";
  constant OP_LB     : std_logic_vector(5 downto 0) := "100000";
  constant OP_LBU    : std_logic_vector(5 downto 0) := "100100";
  constant OP_LHU    : std_logic_vector(5 downto 0) := "100101";
  constant OP_LUI    : std_logic_vector(5 downto 0) := "001111";
  constant OP_LW     : std_logic_vector(5 downto 0) := "100011";
  constant OP_ORI    : std_logic_vector(5 downto 0) := "001101";
  constant OP_SLTI   : std_logic_vector(5 downto 0) := "001010";
  constant OP_SLTIU  : std_logic_vector(5 downto 0) := "001011";
  constant OP_SB     : std_logic_vector(5 downto 0) := "101000";
  constant OP_SH     : std_logic_vector(5 downto 0) := "101000";
  constant OP_SW     : std_logic_vector(5 downto 0) := "101011";
  constant OP_J      : std_logic_vector(5 downto 0) := "000010";
  constant OP_JAL    : std_logic_vector(5 downto 0) := "000011";

  -----------------------------------------------------------------------------
  -- ALU control codes.
  -----------------------------------------------------------------------------
  constant ALU_NOP   : std_logic_vector(3 downto 0) := "0000";
  constant ALU_ADD   : std_logic_vector(3 downto 0) := "0001";
  constant ALU_SUB   : std_logic_vector(3 downto 0) := "0010";
  constant ALU_AND   : std_logic_vector(3 downto 0) := "0011";
  constant ALU_OR    : std_logic_vector(3 downto 0) := "0100";
  constant ALU_NOR   : std_logic_vector(3 downto 0) := "0101";
  constant ALU_SLL   : std_logic_vector(3 downto 0) := "0110";
  constant ALU_SLT   : std_logic_vector(3 downto 0) := "0111";
  constant ALU_SLTU  : std_logic_vector(3 downto 0) := "1000";
  constant ALU_SLTI  : std_logic_vector(3 downto 0) := "1001";
  constant ALU_SLTIU : std_logic_vector(3 downto 0) := "1010";
  constant ALU_LUI   : std_logic_vector(3 downto 0) := "1011";
  constant ALU_JR    : std_logic_vector(3 downto 0) := "1100";

  -----------------------------------------------------------------------------
  -- Function codes.
  -----------------------------------------------------------------------------
  constant FUNCT_ADD  : std_logic_vector(5 downto 0) := "100000";
  constant FUNCT_ADDU : std_logic_vector(5 downto 0) := "100001";
  constant FUNCT_AND  : std_logic_vector(5 downto 0) := "100100";
  constant FUNCT_JR   : std_logic_vector(5 downto 0) := "001000";
  constant FUNCT_NOR  : std_logic_vector(5 downto 0) := "100111";
  constant FUNCT_OR   : std_logic_vector(5 downto 0) := "100101";
  constant FUNCT_SLT  : std_logic_vector(5 downto 0) := "101010";
  constant FUNCT_SLTU : std_logic_vector(5 downto 0) := "101011";
  constant FUNCT_SLL  : std_logic_vector(5 downto 0) := "000000";
  constant FUNCT_SRL  : std_logic_vector(5 downto 0) := "000010";
  constant FUNCT_SUB  : std_logic_vector(5 downto 0) := "100010";
  constant FUNCT_SUBU : std_logic_vector(5 downto 0) := "100011";

end const_package;

package body const_package is

end const_package;
