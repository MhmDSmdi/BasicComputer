library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity MAR is
    Port ( D : in  STD_LOGIC_VECTOR (7 downto 0);
           A : out  STD_LOGIC_VECTOR (4 downto 0);
           LE : in  STD_LOGIC
			  );
end MAR;

architecture Behavioral of MAR is
signal reg : STD_LOGIC_VECTOR (7 downto 0);
begin
	process(D, LE)
	begin
		if(LE = '1') then
		-- reg <= D;
		    A <= D(4 downto 0);
		end if;
	end process;  
end Behavioral;

