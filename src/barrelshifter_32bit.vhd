library IEEE;
use IEEE.std_logic_1164.all;

entity barrelshifter_32bit is
   port(i_A		        : in std_logic_vector(31 downto 0);
        i_B		        : in std_logic_vector(31 downto 0);
        i_Op			: in std_logic_vector(2 downto 0);
        i_S     		: in std_logic_vector(4 downto 0);
        i_A 			: in std_logic;
        i_L 			: in std_logic;
        i_ALUControl 	: in std_logic;
        o_O			    : out std_logic_vector(31 downto 0);
        o_Cout	        : out std_logic
        o_OF 	        : out std_logic
        zero 	        : out std_logic);
end barrelshifter_32bit;

architecture structural of barrelshifter_32bit is

component ALU_32bit
   port(i_D0		        : in std_logic_vector(31 downto 0);
        i_D1                	: in std_logic_vector(31 downto 0);
        i_D2                	: in std_logic_vector(3 downto 0); --op
        i_D3                    : in std_logic_vector(4 downto 0); --shamt
        i_Overflow              : in std_logic;
        o_O                 	: out std_logic_vector(31 downto 0); --out
        o_Overflow          	: out std_logic; --overflow
        o_zero                 	: out std_logic);

end component;

component BarrelShifter
   port(i_clk		: in std_logic;
        i_I		: in std_logic_vector(31 downto 0);
        i_S		: in std_logic_vector (4 downto 0);
        i_A		: in std_logic;		-- 0 == logical and 1 == arithmetic
        i_L		: in std_logic;		-- 0 == right and 1 == left
        o_O		: out std_logic_vector(31 downto 0));
end component;

component mux_32bit_dataflow
   generic(N : integer := 32);
   port(i_D0 : in std_logic_vector(N-1 downto 0);	--0
       	i_D1 : in std_logic_vector(N-1 downto 0);	--1
        i_S : in std_logic;
        o_O : out std_logic_vector(N-1 downto 0));
end component;

signal s_ALU 	 : std_logic_vector(31 downto 0);
signal s_shift   : std_logic_vector(31 downto 0);

begin

end structural;
