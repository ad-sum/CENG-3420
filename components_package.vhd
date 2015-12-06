library IEEE;
use IEEE.std_logic_1164.all;
use work.const_package.all;

package components_package is

  component instruction_fetch
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
  end component;

  component controller
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
  end component;

  component memtable
    port (
      clk		:	in std_logic;
		  rst		:	in std_logic;
		  instaddr:	in std_logic_vector(31 downto 0);
		  instout	:	out std_logic_vector(31 downto 0);
		  wen		:	in std_logic;
		  addr	:	in std_logic_vector(31 downto 0);
		  din		:	in std_logic_vector(31 downto 0);
		  dout	:	out std_logic_vector(31 downto 0);
		  extwen	:	in std_logic;
		  extaddr	:	in std_logic_vector(31 downto 0);
		  extdin	:	in std_logic_vector(31 downto 0);
		  extdout	:	out std_logic_vector(31 downto 0)
      );
  end component;

  component regtable
    port (
      clk     : in  std_logic;
      rst     : in  std_logic;
      raddrA  : in  std_logic_vector(4 downto 0);
      raddrB  : in  std_logic_vector(4 downto 0);
      wen     : in  std_logic;
      waddr   : in  std_logic_vector(4 downto 0);
      din     : in  std_logic_vector(31 downto 0);
      doutA   : out std_logic_vector(31 downto 0);
      doutB   : out std_logic_vector(31 downto 0);
      extaddr : in  std_logic_vector(4 downto 0);
      extdout : out std_logic_vector(31 downto 0)
    );
  end component;

  component sign_extend
    port (
      in_Data  : in  std_logic_vector(15 downto 0);
      out_Data : out std_logic_vector(31 downto 0)
      );
  end component;

  component ALU32
    port (
      in_Operation : in  std_logic_vector(3 downto 0);
      in_A         : in  std_logic_vector(31 downto 0);
      in_B         : in  std_logic_vector(31 downto 0);
      out_Result   : out std_logic_vector(31 downto 0);
      out_Zero     : out std_logic
      );
  end component;

end components_package;

package body components_package is



end components_package;
