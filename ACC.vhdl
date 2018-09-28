library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity ACC is
    Port ( D : inout  STD_LOGIC_VECTOR (7 downto 0);
           LE : in  STD_LOGIC;
           OE : in  STD_LOGIC
			  );
end ACC;

architecture Behavioral of ACC is
signal reg : STD_LOGIC_VECTOR (7 downto 0);
begin
	process(D, LE, OE)
	begin
		if(LE = '1') then
		reg <= D;
		end if;
		if(OE = '1') then 
		D <= reg;
		else
		D <= "ZZZZZZZZ";
		end if;
	end process;

end Behavioral;

