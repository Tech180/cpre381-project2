-------------------------------------------------------------------------
-- Riley Lawson
-- Department of Electrical and Computer Engineering
-- Iowa State University
-------------------------------------------------------------------------


-- register32bit.vhd
-------------------------------------------------------------------------
-- DESCRIPTION: This file contains an implementation of a 32bit register
-- with a edge-triggered flip flop
-------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use work.reg_array_type.all;

entity register32bit is
   generic(N: integer := 32);
   port(clock        : in std_logic;
        i_rst        : in std_logic;
        i_we         : in std_logic;
        data         : in std_logic_vector(N-1 downto 0);
        o_O          : out std_logic_vector(N-1 downto 0));

end register32bit;

architecture structural of register32bit is

 component dffg
   port(i_CLK        : in std_logic;     -- Clock input
        i_RST        : in std_logic;     -- Reset input
        i_WE         : in std_logic;     -- Write enable input
        i_D          : in std_logic;     -- Data value input
        o_Q          : out std_logic);   -- Data value output
 end component;

begin
    M1: for i in 0 to N-1 generate
        generic_dffg: dffg
        port MAP(i_CLK => clock,
                 i_RST => i_rst,
                 i_WE => i_we,
                 i_D => data(i),
                 o_Q => o_O(i));
    end generate;
end structural;

