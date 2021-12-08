library IEEE;
use IEEE.std_logic_1164.all;

entity register_MEMWB is
   port(clock					      : in std_logic;
        i_rst					      : in std_logic;
        i_WE					      : in std_logic;
        upperImmediate	              : in std_logic;
        sltu	                      : in std_logic;
        jal	                          : in std_logic;
        memToReg	                  : in std_logic;
        regWrite	                  : in std_logic;
        Dmem			              : in std_logic_vector(31 downto 0);
        ALU			                  : in std_logic_vector(31 downto 0);
        upperImmediate1			      : in std_logic_vector(31 downto 0);
        sltu1			              : in std_logic_vector(31 downto 0);
        PC			                  : in std_logic_vector(31 downto 0);
        D0			                  : in std_logic_vector(31 downto 0);
        inst			              : in std_logic_vector(31 downto 0);
        writeaddr				      : in std_logic_vector(4 downto 0);
        o_upperImmediate	          : out std_logic;
        o_sltu	                      : out std_logic;
        o_jal	                      : out std_logic;
        memToReg	                  : out std_logic;
        o_RegWrite	            : out std_logic;
        dataMEM			        : out std_logic_vector(31 downto 0);
        o_ALU			        : out std_logic_vector(31 downto 0);
        o_upperImmediate1			: out std_logic_vector(31 downto 0);
        o_sltu1			        : out std_logic_vector(31 downto 0);
        o_PC			        : out std_logic_vector(31 downto 0);
        data0			        : out std_logic_vector(31 downto 0);
        o_Inst			        : out std_logic_vector(31 downto 0);
        o_writeaddr				: out std_logic_vector(4 downto 0));
end register_MEMWB;

architecture structural of register_MEMWB is

component register32bit is
   generic(N: integer := 32);
   port(clock        : in std_logic;
        i_rst        : in std_logic;
        i_WE         : in std_logic;
        i_D          : in std_logic_vector(N-1 downto 0);
        o_O          : out std_logic_vector(N-1 downto 0));
end component;

component dffg is
   port(clock        : in std_logic;
        i_rst        : in std_logic;
        i_WE         : in std_logic;
        i_D          : in std_logic;
        o_O          : out std_logic);
 end component;

begin

dmem_reg : register32bit
    generic map(N => 32)
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => Dmem,
             o_O => dataMEM);

Inst_reg : register32bit
    generic map(N => 32)
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => inst,
             o_O => o_Inst);

D0 : register32bit
    generic map(N => 32)
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => D0,
             o_O => data0);

ALU_reg : register32bit
    generic map(N => 32)
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => ALU,
             o_O => o_ALU);

writeaddr_reg : register32bit
    generic map(N => 5)
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => writeaddr,
             o_O => o_writeaddr);

sltu1_reg : register32bit
    generic map(N => 32)
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => sltu1,
             o_O => o_sltu1);

upper_immD_reg : register32bit
    generic map(N => 32)
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => upperImmediate1,
             o_O => o_upperImmediate1);

upper_imm_reg : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => upperImmediate,
             o_O => o_upperImmediate);

sltu_reg : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => sltu,
             o_O => o_sltu);

jal_reg : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => jal,
             o_O => o_jal);

MemtoReg_reg : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => memToReg,
             o_O => memToReg);

RegWrite_reg : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => regWrite,
             o_O => o_RegWrite);

PC : register32bit
    generic map(N => 32)
    port map(clock => clock,
             i_rst => i_rst,
             i_WE => i_WE,
             i_D => PC,
             o_O => o_PC);

end structural;