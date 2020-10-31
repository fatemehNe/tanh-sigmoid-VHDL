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


entity tanh is
    generic(int : integer := 4;
		fraction: integer :=20);
    Port ( x : in signed (int + fraction -1 downto 0); 
           clk :in std_logic;
           reset, load :in std_logic;
           f : out STD_LOGIC_VECTOR (int + fraction -1 downto 0));
end tanh;

architecture Behavioral of tanh is

component polynomial is
    generic(int : integer := 4;
		fraction: integer :=14);
    Port ( x : in STD_LOGIC_VECTOR (int + fraction -1  downto 0);
           p0 : in STD_LOGIC_VECTOR (int + fraction -1  downto 0);
           p1 : in STD_LOGIC_VECTOR (int + fraction -1  downto 0);
           p2 : in STD_LOGIC_VECTOR (int + fraction -1  downto 0);
           clk :in std_logic;
           reset, load :in std_logic;
           f : out STD_LOGIC_VECTOR (int + fraction -1  downto 0)
           );
end component;

signal p0,p1,p2 : STD_LOGIC_VECTOR (int + fraction -1 downto 0);

begin

pol: polynomial generic map(int , fraction) port map (STD_LOGIC_VECTOR(x), p0, p1, p2, clk, reset, load, f);


process (x)
begin
    if (x <= "11101000000000000000000000000000") then -- x <= -3
        p0 <= "11111000000000000000000000000000";
        p1 <= "00000000000000000000000000000000";
        p2 <= "00000000000000000000000000000000";
    elsif (x > "11101000000000000000000000000000" and x <= "11111000000000000000000000000000") then  --  -3 < x < -1
        p0 <= "11111100110100001001100100000000";
        p1 <= "00000011101110001110010000000000";
        p2 <= "00000000101110000111100110000000";
    elsif (x > "11111000000000000000000000000000" and x <= "00000000000000000000000000000000") then  --  -1 < x < 0
        p0 <= "00000000000001100111000010000000";
        p1 <= "00001000101010111010010110000000";
        p2 <= "00000010100001110000011000000000";
    elsif (x > "00000000000000000000000000000000" and x < "0001000000000000000000000000000") then -- 0< x < 1
        p0 <= "11111111111110001101011110000000";
        p1 <= "00001000101011101101110110000000";
        p2 <= "11111101011101110100001000000000";
    elsif (x >= "00001000000000000000000000000000" and x < "00011000000000000000000000000000") then -- 1 =< x < 3
        p0 <= "00000011001100001011001110000000";
        p1 <= "00000011101110001000000100000000";
        p2 <= "11111111010001110110011100000000";
    elsif (x >= "00011000000000000000000000000000") then -- x> 3
        p0 <= "00001000000000000000000000000000";
        p1 <= "00000000000000000000000000000000";
        p2 <= "00000000000000000000000000000000";
    end if;
end process;

end Behavioral;
