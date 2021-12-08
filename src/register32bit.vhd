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
   port(clock        : in std_logic;
        i_rst        : in std_logic;
        i_we         : in std_logic;
        data         : in std_logic;
        o_O          : out std_logic);
 end component;

begin
    M1: for i in 0 to N-1 generate
        generic_dflipflop: dflipflop
        port MAP(i_CLK => i_CLK,
                 i_RST => i_RST,
                 i_WE => i_WE,
                 i_D => i_D(i),
                 o_Q => o_Q(i));
    end generate;
end structural;

