library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity dualram is
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
        Reset 	: in  STD_LOGIC := '0';
		cs			: in STD_LOGIC ;
		DataOut : out STD_LOGIC_VECTOR (MEMORY_WIDTH - 1 downto 0);
		DataIn 	: in STD_LOGIC_VECTOR (MEMORY_WIDTH - 1 downto 0);
		Addr	: in  STD_LOGIC_VECTOR (ADDRESS_WIDTH - 1 downto 0);
		ReadAddr	: in  STD_LOGIC_VECTOR (ADDRESS_WIDTH - 1 downto 0);
		WR	: in  STD_LOGIC;
		RD	: in  STD_LOGIC
	);
end dualram;

    architecture Behavioral of dualram is
	    type myRAMarr is array ((2 ** ADDRESS_WIDTH) - 1 downto 0) of STD_LOGIC_VECTOR (MEMORY_WIDTH - 1 downto 0);
	    signal arr : myRAMarr;

begin
	process (Clock, Reset, WR, RD, DataIn, Addr, ReadAddr)
	begin
        if(Reset = '0') then
            for i in 0 to NO_OF_WORDS - 1 loop
                arr(i) <= std_logic_vector(to_unsigned(i, MEMORY_WIDTH));
            end loop;
           elsif rising_edge(Clock) then
           if cs = '0' then
						if WR = '1' then
							 arr(to_integer(unsigned(Addr))) <= DataIn;
						end if;
						if RD = '1' then
							 DataOut <= arr(to_integer(unsigned(ReadAddr)));
						else
							 DataOut <= "ZZZZZZZZ";
						end if;
				end if;
		end if;
	end process;
end Behavioral;