----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/21/2020 01:01:00 PM
-- Design Name: 
-- Module Name: multiplier - Behavioral
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

use IEEE.NUMERIC_STD.ALL;



entity multiplier is
    generic(int : integer := 4;
		    fraction: integer :=14);
	port(a,b: in std_logic_vector(int + fraction -1 downto 0); 
	     reset :in std_logic;
		 res: out std_logic_vector(2 * (int + fraction) -1 downto 0) 
		);
end multiplier;

architecture Behavioral of multiplier is

begin

process(a,b,reset)
begin
    if (reset = '1') then
        res <= (others => '0');
    else 
        res <= std_logic_vector(signed(a) * signed(b));
    end if;
end process;

end Behavioral;


