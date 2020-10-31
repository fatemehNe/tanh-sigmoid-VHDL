----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/11/2020 08:52:44 PM
-- Design Name: 
-- Module Name: sigma - Behavioral
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



entity sigmoid is
    generic(int : integer := 4;
		fraction: integer :=20);
    Port ( x : in signed (int + fraction -1 downto 0); 
           clk :in std_logic;
           reset, load :in std_logic;
           f : out STD_LOGIC_VECTOR (int + fraction -1 downto 0));
end sigmoid;

architecture Behavioral of sigmoid is

component polynomial is
    generic(int : integer := 4;
		fraction: integer :=14);
    Port ( x : in STD_LOGIC_VECTOR (int + fraction -1  downto 0);
           p0 : in STD_LOGIC_VECTOR (int + fraction -1  downto 0);
           p1 : in STD_LOGIC_VECTOR (int + fraction -1  downto 0);
           p2 : in STD_LOGIC_VECTOR (int + fraction -1  downto 0);
           clk :in std_logic;
           reset,load :in std_logic;
           f : out STD_LOGIC_VECTOR (int + fraction -1  downto 0)
           );
end component;

signal p0,p1,p2 : STD_LOGIC_VECTOR (int + fraction -1 downto 0);

begin

pol: polynomial generic map(int , fraction) port map (STD_LOGIC_VECTOR(x), p0, p1, p2, clk, reset,load, f);


process (x)
begin
    if (x <= "11010000000000000000000000000000") then -- x <= -6 
        p0 <= "00000000000000000000000000000000";
        p1 <= "00000000000000000000000000000000";
        p2 <= "00000000000000000000000000000000";
    elsif (x > "11010000000000000000000000000000" and x <= "11101000000000000000000000000000") then --  -6 < x < -3
        p0 <= "00000001101000000011100110000000";
        p1 <= "00000000100100101111100010000000";
        p2 <= "00000000000011010010101010000000";
    elsif (x > "11101000000000000000000000000000" and x <= "00000000000000000000000000000000") then  --  -3 < x < 0
        p0 <= "00000100000001000000001010000000";
        p1 <= "00000010001011100111100110000000";
        p2 <= "00000000010100110010001000000000";
    elsif (x > "00000000000000000000000000000000" and x <= "00011000000000000000000000000000") then -- 0< x < 3
        p0 <= "00000011111111000000011000000000";
        p1 <= "00000010001011100110100110000000";
        p2 <= "11111111101011001110010000000000";
    elsif (x > "00011000000000000000000000000000" and x < "00110000000000000000000000000000") then -- 3 < x < 6
        p0 <= "00000110010111111100001000000000";
        p1 <= "00000000100100101111001110000000";
        p2 <= "11111111111100101101011010000000";
    elsif (x >= "00110000000000000000000000000000") then -- x> 6
         p0 <= "00001000000000000000000000000000";
         p1 <= "00000000000000000000000000000000";
         p2 <= "00000000000000000000000000000000";
    end if;
end process;

end Behavioral;
