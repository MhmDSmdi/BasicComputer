library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity SEQ is
   Generic (HOWMANY: STD_LOGIC_VECTOR(3 downto 0) := "0101");
    Port ( CLK : in  STD_LOGIC;
           RST : in STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (3 downto 0)
    );
    end SEQ;

architecture Behavioral of SEQ is
    signal count   : STD_LOGIC_VECTOR (3 downto 0) := "0000";
begin


    process (CLK)
    begin
    if(RST = '1') then 
    count <= "0000";
    elsif (rising_edge(CLK)) then
        if(count + '1' > "0111") then
        count <= "0000";
        else
           count <= count + '1';   
    end if;
    end if;
    end process;
    
    DOUT <= count;
    
end Behavioral;