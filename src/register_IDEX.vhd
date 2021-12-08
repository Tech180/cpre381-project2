library IEEE;
use IEEE.std_logic_1164.all;

entity register_IDEX is
   generic(N: integer := 32);
   port(clock       			: in std_logic;
        i_rst        			: in std_logic;
        i_we         			: in std_logic;
        upperImmediate          : in std_logic;
        regdst                  : in std_logic;
        sltu                  : in std_logic;
        jal                   : in std_logic;
        memtoreg                : in std_logic;
        regWrite                : in std_logic;
        memWrite                : in std_logic;
        ALUSrc                  : in std_logic;
        sl                    : in std_logic; --shift left
        sr                    : in std_logic; --shift right
        ALUControl              : in std_logic;
        sv                      : in std_logic; --shift variable
        branch                  : in std_logic;
        jr                      : in std_logic;
        op				        : in std_logic_vector(2 downto 0);
        writeaddr            	: in std_logic_vector(4 downto 0);
        rd                    	: in std_logic_vector(4 downto 0);
        rt                      : in std_logic_vector(4 downto 0);
        shamt	                : in std_logic_vector(4 downto 0);
        rt1           			: in std_logic_vector(N-1 downto 0);
        rd1  			        : in std_logic_vector(N-1 downto 0);
        immediateExtend        : in std_logic_vector(N-1 downto 0);
        PC			        : in std_logic_vector(N-1 downto 0);
        D0			        : in std_logic_vector(N-1 downto 0);
        inst			        : in std_logic_vector(N-1 downto 0);

        o_upperImmediate        : out std_logic;
        o_RegDst                : out std_logic;
        o_sltu                  : out std_logic;
        o_jal                   : out std_logic;
        o_MemtoReg              : out std_logic;
        o_RegWrite              : out std_logic;
        o_MemWrite              : out std_logic;
        o_ALUSrc                : out std_logic;
        o_sl                    : out std_logic;
        o_sr                    : out std_logic;
        o_ALUControl            : out std_logic;
        o_sv                    : out std_logic;
        o_branch                : out std_logic;
        o_jr                    : out std_logic;
        o_op				    : out std_logic_vector(2 downto 0);
        o_writeaddr	            : out std_logic_vector(4 downto 0);
        o_rd	                : out std_logic_vector(4 downto 0);
        o_rt	                : out std_logic_vector(4 downto 0);
        o_shamt	                : out std_logic_vector(4 downto 0);
        o_rt1			        : out std_logic_vector(N-1 downto 0);
        o_rd1			        : out std_logic_vector(N-1 downto 0);
        o_immediateExtend			    : out std_logic_vector(N-1 downto 0);
        o_PC		            : out std_logic_vector(N-1 downto 0);
        o_D0			        : out std_logic_vector(N-1 downto 0);
        o_inst			        : out std_logic_vector(N-1 downto 0));
end register_IDEX;

architecture structural of register_IDEX is

component register32bit
generic(N: integer := 32);
   port(clock                   : in std_logic;
        i_rst                   : in std_logic;
        i_we                    : in std_logic;
        data                    : in std_logic_vector(N-1 downto 0);
        o_O                     : out std_logic_vector(N-1 downto 0));
end component;

component dffg
   port(clock                   : in std_logic;
        i_rst                   : in std_logic;
        i_we                    : in std_logic;
        data                    : in std_logic;
        o_O                     : out std_logic);
end component;

begin

generic_wrAddr : register32bit
    generic map(N => 5)
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => writeaddr,
             o_O => o_writeaddr);

generic_inst : register32bit
    generic map(N => 32)
    port map(clock => clock,
            i_rst => i_rst,
            i_we => i_we,
            data => inst,
            o_O => o_inst);

generic_32bitregister: register32bit
    generic map(N => 32)
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => D0,
             o_O => o_D0);

generic_rd : register32bit
    generic map(N => 5)
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => rd,
             o_O => o_rd);

generic_rt : register32bit
    generic map(N => 5)
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => rt,
             o_O => o_rt);

generic_shamt : register32bit
    generic map(N => 5)
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => shamt,
             o_O => o_shamt);

generic_rtD : register32bit
    generic map(N => 32)
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => rt1,
             o_O => o_rt1);

generic_rd1 : register32bit
    generic map(N => 32)
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => rd1,
             o_O => o_rd1);

generic_immediateExtend : register32bit
    generic map(N => 32)
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => immediateExtend,
             o_O => o_immediateExtend);

generic_op : register32bit
    generic map(N => 3)
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => op,
             o_O => o_op);

generic_upperImmediate : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => upperImmediate,
             o_O => o_upperImmediate);

generic_sltu : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => sltu,
             o_O => o_sltu);

generic_jal : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => jal,
             o_O => o_jal);

generic_memtoReg : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => memtoreg,
             o_O => o_MemtoReg);

generic_register_Write : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => regwrite,
             o_O => o_RegWrite);

generic_memory_Write : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => memWrite,
             o_O => o_memWrite);

generic_ALUSrc : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => ALUSrc,
             o_O => o_ALUSrc);

generic_sl : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => sl,
             o_O => o_sl);

generic_sr : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => sr,
             o_O => o_sr);

generic_ALUControl : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => ALUControl,
             o_O => o_ALUControl);

generic_shiftvariable : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => sv,
             o_O => o_sv);

generic_register_Dst : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => regdst,
             o_O => o_RegDst);

generic_branch : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => branch,
             o_O => o_branch);

generic_jump_and_register : dffg
    port map(clock => clock,
             i_rst => i_rst,
             i_we => i_we,
             data => jr,
             o_O => o_jr);
generic_PC : register32bit
    generic map(N => 32)
    port map(clock => clock,
            i_rst => i_rst,
            i_we => i_we,
            data => PC,
            o_O => o_PC);

end structural;
