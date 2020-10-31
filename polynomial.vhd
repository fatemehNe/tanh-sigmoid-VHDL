----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/02/2020 06:54:17 PM
-- Design Name: 
-- Module Name: polynomial - Behavioral
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
use ieee.std_logic_unsigned.all;

use IEEE.NUMERIC_STD.ALL;



entity polynomial is
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
end polynomial;

architecture Behavioral of polynomial is

component FlipFlop is 
    generic(int : integer := 4;
            fraction: integer :=14);
    port(
       Q : out STD_LOGIC_VECTOR (int + fraction -1 downto 0);    
       Clk, reset :in std_logic;   
       D :in  STD_LOGIC_VECTOR (int + fraction -1 downto 0)    
    );
end component FlipFlop; 

component multiplexer is
    generic(int : integer := 4;
		fraction: integer :=14);
    Port ( p0 : in STD_LOGIC_VECTOR (int + fraction -1 downto 0);
           p1 : in STD_LOGIC_VECTOR (int + fraction -1 downto 0);
           output : out STD_LOGIC_VECTOR (int + fraction -1 downto 0);
           selector : in STD_LOGIC);
end component;

component multiplier IS
  generic(int : integer := 4;
		  fraction: integer :=14);
  port(a,b: in std_logic_vector(int + fraction -1 downto 0); 
       reset :in std_logic; 
       res: out std_logic_vector(2 * (int + fraction) -1 downto 0) 
       );
END component multiplier;


signal sum, pro , sumout , sigout:STD_LOGIC_VECTOR (int + fraction -1 downto 0);
signal proout : STD_LOGIC_VECTOR (2*(int + fraction) -1 downto 0);
signal shiftout: signed (2 * (int + fraction) -1 downto 0);
signal selector: STD_LOGIC_VECTOR (0 downto 0) := "0";
signal cnt,check : integer := 0;

begin

f1: FlipFlop generic map(int , fraction) port map (sigout,clk,reset,sumout); -- akhari
m0: multiplexer generic map(int , fraction) port map (p1,p0,sum,selector(0)); -- payini
m1: multiplexer generic map(int , fraction) port map (p2,sigout,pro,selector(0)); -- balayi
mul0: multiplier generic map(int , fraction) port map ( x , pro, reset,proout);

pr1 : process (clk)
    variable v1: std_logic_vector(0 downto 0);
    variable ct: std_logic_vector(1 downto 0) := "00";
    BEGIN
        if(reset='1') then 
            selector <= "0";
        elsif(rising_edge(clk)) then
            ct := ct + "01";
            --if (ct(0)='0') then 
                v1 := selector;
                selector <= '1' + v1;
            --end if;
        end if;  
end process;

process(reset, proout )
begin
if (reset ='1') then
    shiftout <=(others => '0');
else
    shiftout <= shift_right(signed(proout),fraction);

end if ;
end process;

process(reset , shiftout, sum)
begin
if (reset ='1') then
    sumout <= (others => '0');
else
    sumout <= std_logic_vector(shiftout(int + fraction -1 downto 0) + signed(sum));

end if ;
end process;


process(x, reset)
variable ch: integer;
begin
    if (reset = '1') then 
        check <= 0;
    else
        ch := check;
        check <= ch + 1;
    end if;
end process;

process(check, reset,clk)
variable v : integer;
variable chk: integer := 0;
begin
    if (reset = '1') then 
        cnt <= 0;
    elsif (chk /= check) then
        cnt <= 0;
        if selector(0) = '0' then 
            v := 2;
        elsif selector(0) = '1' then 
            v := 3;
        end if;
    else
        if (rising_edge(clk)) then 
            if (cnt /= v) then
                cnt <=cnt+1;
            elsif (cnt = v) then
                f <= sigout;
                cnt <=cnt+1;
            end if;
        end if;
    end if;
    chk := check;
end process;

end Behavioral;
