library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity singleram is
	Generic (
        -- W
		MEMORY_WIDTH		: integer := 8;
        -- D
		NO_OF_WORDS	: integer := 8;
        -- C == log2 (D)
		ADDRESS_WIDTH	: integer := 3
	);
	Port ( 
		Clock 	: in  STD_LOGIC;
        Reset 	: in  STD_LOGIC;
        CS 	: in  STD_LOGIC;
		Data 	: inout STD_LOGIC_VECTOR (MEMORY_WIDTH - 1 downto 0) := "ZZZZZZZZ";
		Addr	: in  STD_LOGIC_VECTOR (ADDRESS_WIDTH - 1 downto 0);
		WR	: in  STD_LOGIC;
		RD	: in  STD_LOGIC
	);
end singleram;

    architecture Behavioral of singleram is
	    type myRAMarr is array ((2 ** ADDRESS_WIDTH) - 1 downto 0) of STD_LOGIC_VECTOR (MEMORY_WIDTH - 1 downto 0);
	    signal arr : myRAMarr;

begin
	process (Clock, Reset, WR, RD, Data, Addr)
	begin
        if(Reset = '1') then
            for i in 0 to NO_OF_WORDS - 1 loop
                arr(i) <= "00000000";
            end loop;
				arr(0) <= "11111111";
				arr(1) <= "00000011";
			
				
        elsif rising_edge(Clock) then
		if(CS = '1') then
            if WR = '1' then
                arr(to_integer(unsigned(Addr))) <= Data;
            elsif RD = '1' then
                Data <= arr(to_integer(unsigned(Addr)));
            else
                Data <= "ZZZZZZZZ";
            end if;
		end if;
		end if;
	end process;


end Behavioral;