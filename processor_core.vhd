library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use work.const_package.all;
use work.components_package.all;

entity processor_core is
  port (
    clk      : in  std_logic;
    rst      : in  std_logic;
    run      : in  std_logic;
    instaddr : out std_logic_vector(31 downto 0);
    inst     : in  std_logic_vector(31 downto 0);
    memwen   : out std_logic;
    memaddr  : out std_logic_vector(31 downto 0);
    memdw    : out std_logic_vector(31 downto 0);
    memdr    : in  std_logic_vector(31 downto 0);
    fin      : out std_logic;
    PCout    : out std_logic_vector(31 downto 0);
    regaddr  : in  std_logic_vector(4 downto 0);
    regdout  : out std_logic_vector(31 downto 0)
  );
end processor_core;

architecture arch_processor_core of processor_core is
-- Add the register table here
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

-- Add signals here
  -- Processor
  signal PC : std_logic_vector(31 downto 0) := PC_Initial;
  signal Running : std_logic := '0';

  -- Instruction Memory
  signal Instruction : std_logic_vector(31 downto 0);

  -- Instruction Decoder
  signal Opcode   : std_logic_vector(5 downto 0);
  signal RS       : std_logic_vector(4 downto 0);
  signal RT       : std_logic_vector(4 downto 0);
  signal RD       : std_logic_vector(4 downto 0);
  signal Shamt    : std_logic_vector(4 downto 0);
  signal Funct    : std_logic_vector(5 downto 0);
  signal IAddress : std_logic_vector(15 downto 0);
  signal JAddress : std_logic_vector(25 downto 0);

  -- controller
  signal RegDst   : std_logic;
  signal Branch   : std_logic;
  signal MemRead  : std_logic;
  signal MemWrite : std_logic;
  signal ALUOp    : std_logic_vector(3 downto 0);
  signal MemtoReg : std_logic;
  signal ALUSrc   : std_logic;
  signal RegWrite : std_logic;
  signal Jump     : std_logic;

  -- Register File
  signal WriteReg      : std_logic_vector(4 downto 0);
  signal RegData1      : std_logic_vector(31 downto 0);
  signal RegData2      : std_logic_vector(31 downto 0);
  signal WriteBackData : std_logic_vector(31 downto 0);

  -- Sign Extender
  signal ExtendedAddress : std_logic_vector(31 downto 0);
  signal BranchOffset : std_logic_vector(31 downto 0);

  -- ALU
  signal InputA    : std_logic_vector(31 downto 0);
  signal InputB    : std_logic_vector(31 downto 0);
  signal ALUResult : std_logic_vector(31 downto 0);
  signal ZeroFlag  : std_logic;

  -- Data Memory
  signal MemoryData : std_logic_vector(31 downto 0);

  -- Program Counter
  signal NextAddress    : std_logic_vector(31 downto 0);
  signal BranchAddress  : std_logic_vector(31 downto 0);
  signal JumpAddress    : std_logic_vector(31 downto 0);
  signal CorrectAddress : std_logic_vector(31 downto 0);

begin
-- Processor Core Behaviour

    -----------------------------------------------------------------------------
    -- Instantiate the memory.
    -----------------------------------------------------------------------------
    instaddr <= PC;
    Instruction <= inst;
    MemoryData  <= memdr;
    memwen  <= MemWrite;
    memaddr <= ALUResult;
    memdw   <= RegData2;
    PCout   <= PC;
    
    -----------------------------------------------------------------------------
    -- Instantiate the instruction decoder.
    -----------------------------------------------------------------------------
    InstructionDecode : instruction_fetch
      port map (
        in_Instruction => Instruction,
        out_Opcode     => Opcode,
        out_RS         => RS,
        out_RT         => RT,
        out_RD         => RD,
        out_Shamt      => Shamt,
        out_Funct      => Funct,
        out_IAddress   => IAddress,
        out_JAddress   => JAddress
      );
    -- TODO: JAL write back
    --RT <= Reg_31 when (OpCode = OP_JAL);
    --ALUResult <= std_logic_vector(unsigned(PC) + 8) when (OpCode = OP_JAL);

    -----------------------------------------------------------------------------
    -- Instantiate the main control block.
    -----------------------------------------------------------------------------
    Control : controller
      port map (
        in_Opcode    => Opcode,
        in_Funct     => Funct,
        out_RegDst   => RegDst,
        out_Branch   => Branch,
        out_MemRead  => MemRead,
        out_MemWrite => MemWrite,
        out_ALUOp    => ALUOp,
        out_MemtoReg => MemtoReg,
        out_ALUSrc   => ALUSrc,
        out_RegWrite => RegWrite,
        out_Jump     => Jump
      );

    -----------------------------------------------------------------------------
    -- Instantiate the register file.
    -----------------------------------------------------------------------------
    WriteReg      <= RT        when (RegDst = '0')   else RD;
    WriteBackData <= ALUResult when (MemtoReg = '0') else MemoryData;

    RegFile : regtable
      port map (
        clk		  => clk,
		    rst		  => rst,
		    raddrA  => RS,
		    raddrB  => RT,
		    wen		  => RegWrite,
		    waddr   => WriteReg,
		    din		  => WriteBackData,
		    doutA   => RegData1,
		    doutB	  => RegData2,
		    extaddr	=> regaddr,
	    	extdout	=> regdout
      );

    -----------------------------------------------------------------------------
    -- Instantiate the sign extender.
    -----------------------------------------------------------------------------
    SignExtend : sign_extend
      port map (
        in_Data  => IAddress,
        out_Data => ExtendedAddress
      );

    -----------------------------------------------------------------------------
    -- Instantiate the ALU.
    -----------------------------------------------------------------------------
    InputA <= RegData1;
    InputB <= RegData2 when (ALUSrc = '0') else ExtendedAddress;

    ALU : ALU32
      port map (
        in_Operation => ALUOp,
        in_A         => InputA,
        in_B         => InputB,
        out_Result   => ALUResult,
        out_Zero     => ZeroFlag
      );
    BranchOffset <= std_logic_vector(unsigned(ExtendedAddress) sll 2);
    
    StartRun : process (run)
    begin
      if run = '1' then
        Running <= '1';
      end if;
    end process StartRun;

    UpdatePC : process (clk, rst, run)
    begin
      
      NextAddress   <= std_logic_vector(unsigned(PC) + 4);
      BranchAddress <= std_logic_vector(unsigned(PC) + 4 + unsigned(BranchOffset));
      JumpAddress   <= NextAddress(31 downto 28) & JAddress & "00";

      if rst = '1' then
        PC <= PC_Initial;       
        fin <= '0';
        --Running <= '0';
      elsif Running = '1' and rising_edge(clk) then
        if Instruction = Final_Instruction then
          PCout <= PC;
          fin   <= '1';
        elsif Jump = '1' then
          if ALUOp = ALU_JR then
            PC <= RegData1;
          else
            PC <= JumpAddress;
          end if;
        elsif Branch = '1' then
          if OpCode = OP_BEQ and ZeroFlag = '1' then
            PC <= BranchAddress;
          elsif OpCode = OP_BNE and ZeroFlag = '0' then
            PC <= BranchAddress;
          else
            PC <= NextAddress;
          end if;
        else
          PC <= NextAddress;
        end if;
      end if;
      
    end process UpdatePC;
    
end arch_processor_core;
