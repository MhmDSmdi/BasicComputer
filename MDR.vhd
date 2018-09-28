library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MDR is
    Port ( DIN : inout  STD_LOGIC_VECTOR (7 downto 0);
           DOUT : inout  STD_LOGIC_VECTOR (7 downto 0);
           LE_IN : in  STD_LOGIC;
           LE_OUT : in  STD_LOGIC;
           OE_IN : in  STD_LOGIC;
           OE_OUT : in  STD_LOGIC);
end MDR;

architecture Behavioral of MDR is
signal reg : STD_LOGIC_VECTOR(7 downto 0);
begin
process(DIN,DOUT,LE_IN,LE_OUT,OE_IN,OE_OUT)
begin

    if(LE_IN = '1') then 
        reg <= DIN;
	elsif(LE_OUT = '1') then 
        reg <= DOUT;
    end if;

	
    if(OE_IN = '1') then 
        DIN <= reg;
    else
        DIN <= "ZZZZZZZZ";
    end if;
	
	if(OE_OUT = '1') then 
        DOUT <= reg;
    else
        DOUT <= "ZZZZZZZZ";
    end if;


end process;

end Behavioral;

