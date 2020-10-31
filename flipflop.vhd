----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2020 01:54:07 PM
-- Design Name: 
-- Module Name: flipflop - Behavioral
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


entity FlipFlop is 
    generic(int : integer := 4;
            fraction: integer :=14);
    port(
       Q : out STD_LOGIC_VECTOR (int + fraction -1 downto 0);    
       Clk,reset:in std_logic;   
       D :in  STD_LOGIC_VECTOR (int + fraction -1 downto 0)    
    );
end FlipFlop;


architecture Behavioral of FlipFlop is  
begin  

 process(Clk,reset)
 begin 
    if (reset = '1') then
        Q <= (others=>'0');
    elsif(rising_edge(Clk)) then
        Q <= D; 
    end if;       
 end process;  
 
end Behavioral; 