library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity PC is
    Port ( 
           D : inout  STD_LOGIC_VECTOR (7 downto 0);
           LE : in  STD_LOGIC;
           OE : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           INC : in  STD_LOGIC
			  );
end PC;

architecture Behavioral of PC is
signal reg : STD_LOGIC_VECTOR(7 downto 0);
begin
process(CLK)
begin
if(CLR = '1') then
            reg <= "00000000";
elsif(rising_edge(CLK)) then
                   if(LE = '1') then
            reg <= D;
            elsif(INC = '1') then
            reg <= reg + "00000001";
            end if;
end if;
    -- if(OE = '1') then
    -- D <= reg;
    -- else
    -- D <= "ZZZZZZZZ";
    -- end if;
end process;
D <= reg when(OE = '1') else "ZZZZZZZZ";
end Behavioral;

