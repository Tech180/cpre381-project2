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

entity Register32bit is
	generic(N : integer := 32);
	port(i_Data : in std_logic_vector(N-1 DOWNTO 0) := (others => '0');
             clk : in std_logic := '0';
             wren : in std_logic := '0';
             reset : in std_logic := '0';
             o_Data : out std_logic_vector(N-1 DOWNTO 0) := (others => '0')
	     );

end Register32bit;

--  Architecture Body

architecture bigboy of Register32bit is

begin

process (clk, reset)
begin
  if (rising_edge(clk)) then
    if (not(reset = '1') AND wren = '1') then
      o_Data <= i_Data;
    end if;
    if (reset = '1') then
      o_Data <= std_logic_vector(to_unsigned(0, N));
    end if;
  end if;
end process;

end bigboy;

