library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity sign_extend is
  port (
    in_Data  : in  std_logic_vector(15 downto 0);
    out_Data : out std_logic_vector(31 downto 0)
    );
end sign_extend;

architecture behavioral of sign_extend is
begin

  UpdateOutput: process (in_Data)
  begin
    out_Data(15 downto 0) <= in_Data(15 downto 0);
    out_Data(31 downto 16) <= (others => in_Data(15));
  end process UpdateOutput;

end behavioral;
