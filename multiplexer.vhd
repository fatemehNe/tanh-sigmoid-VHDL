----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2020 02:48:41 PM
-- Design Name: 
-- Module Name: multiplexer - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity multiplexer is
    generic(int : integer := 4;
		fraction: integer :=14);
    Port ( p0 : in STD_LOGIC_VECTOR (int + fraction -1  downto 0);
           p1 : in STD_LOGIC_VECTOR (int + fraction -1  downto 0);
           output : out STD_LOGIC_VECTOR (int + fraction -1  downto 0);
           selector : in STD_LOGIC);
end multiplexer;

architecture Behavioral of multiplexer is

begin

output <= p1 when (selector = '1') else p0;

-- process(selector)
--begin 
--   if(selector = '0') then
--        output <= p0; 
--   elsif(selector = '1')then
--        output <= p1;
--   end if;       
--end process; 
end Behavioral;
