library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.const_package.all;

entity ALU32 is
  port (
    in_Operation : in  std_logic_vector(3 downto 0);
    in_A         : in  std_logic_vector(31 downto 0);
    in_B         : in  std_logic_vector(31 downto 0);
    out_Result   : out std_logic_vector(31 downto 0);
    out_Zero     : out std_logic
    );
end ALU32;

architecture behavioral of ALU32 is

  signal Result : std_logic_vector(31 downto 0);
  
begin

  out_Result <= Result;
  out_Zero   <= '1' when (Result = x"00000000") else '0';

  UpdateOutputs : process (in_Operation, in_A, in_B)
  begin
    case in_Operation is
      when ALU_ADD => Result <= std_logic_vector(signed(in_A) + signed(in_B));
      when ALU_SUB => Result <= std_logic_vector(signed(in_A) - signed(in_B));
      when ALU_AND => Result <= in_A and in_B;
      when ALU_OR  => Result <= in_A or in_B;
      when ALU_NOR => Result <= not (in_A or in_B);
      when ALU_SLL => Result <= std_logic_vector(unsigned(in_A) sll to_integer(signed(in_B)));
      when ALU_SLT | ALU_SLTI =>
        if signed(in_A) < signed(in_B) then
          Result <= x"00000001";
        else
          Result <= x"00000000";
        end if;
      when ALU_SLTU | ALU_SLTIU =>
        if unsigned(in_A) < unsigned(in_B) then
          Result <= x"00000001";
        else
          Result <= x"00000000";
        end if;
      when ALU_LUI => Result <= std_logic_vector(unsigned(in_B) sll 16);
      when others => Result <= (others => '0');
    end case;
  end process UpdateOutputs;

end behavioral;
