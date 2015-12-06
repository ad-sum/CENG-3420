library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity instruction_fetch is
  port (
    in_Instruction : in  std_logic_vector(31 downto 0);
    out_Opcode     : out std_logic_vector(5 downto 0);
    out_RS         : out std_logic_vector(4 downto 0);
    out_RT         : out std_logic_vector(4 downto 0);
    out_RD         : out std_logic_vector(4 downto 0);
    out_Shamt      : out std_logic_vector(4 downto 0);
    out_Funct      : out std_logic_vector(5 downto 0);
    out_IAddress   : out std_logic_vector(15 downto 0);
    out_JAddress   : out std_logic_vector(25 downto 0)
    );
end instruction_fetch;

architecture structural of instruction_fetch is

begin

  out_Opcode   <= in_Instruction(31 downto 26);
  out_RS       <= in_Instruction(25 downto 21);
  out_RT       <= in_Instruction(20 downto 16);
  out_RD       <= in_Instruction(15 downto 11);
  out_Shamt    <= in_Instruction(10 downto 6);
  out_Funct    <= in_Instruction(5 downto 0);
  out_IAddress <= in_Instruction(15 downto 0);
  out_JAddress <= in_Instruction(25 downto 0);

end structural;
