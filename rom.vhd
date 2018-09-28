library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;


entity rom is
	Generic (
        -- W
		MEMORY_WIDTH		: integer := 8;
        -- D
		NO_OF_WORDS	: integer := 16;
        -- C == log2 (D)
		ADDRESS_WIDTH	: integer := 4
	);
	Port ( 
		Clock 	: in  STD_LOGIC;
        Reset 	: in  STD_LOGIC;
		cs		: in STD_LOGIC ;
		Data 	: out STD_LOGIC_VECTOR (MEMORY_WIDTH - 1 downto 0) := "ZZZZZZZZ";
		Addr	: in  STD_LOGIC_VECTOR (ADDRESS_WIDTH - 1 downto 0);
		RD	: in  STD_LOGIC
	);
end rom;

    architecture Behavioral of rom is
	    type myRAMarr is array ((2 ** ADDRESS_WIDTH) - 1 downto 0) of STD_LOGIC_VECTOR (MEMORY_WIDTH - 1 downto 0);
	    signal arr : myRAMarr;

begin
	process (Clock, Reset, RD, Addr)
	begin
        if(Reset = '1') then
            for i in 0 to NO_OF_WORDS - 1 loop
                arr(i) <= "00000000";
            end loop;
							-- Using TWO IOs one for input and one for output
							arr(0) <= "00011110"; -- LOAD operand1 from IO
							arr(1) <= "00110111"; -- STORE loaded data into RAM[7]
							arr(2) <= "00011111"; -- LOAD operand2 from IO
							-- arr(3) <= "00110110"; -- STORE loaded data into[6]
							arr(3) <= "10110111"; -- ADD loaded value to RAM[7]
							arr(4) <= "11100000"; -- SHR result (/2)
							arr(5) <= "00111101"; -- put result in IO




							arr(6) <= "01000110"; -- LOOP [not important]

							-- Using TWO way IO (third) :
							-- arr(0) <= "00011111"; -- LOAD operand1 from IO
							-- arr(1) <= "00110111"; -- STORE loaded data into RAM[7]
							-- arr(2) <= "00011111"; -- LOAD operand2 from IO
							-- -- arr(3) <= "00110110"; -- STORE loaded data into[6]
							-- arr(3) <= "10110111"; -- ADD loaded value to RAM[7]
							-- arr(4) <= "11100000"; -- SHR result (/2)
							-- arr(5) <= "00111111"; -- put result in IO


        elsif rising_edge(Clock) then
				if cs = '1' then
					if RD = '1' then
						 Data <= arr(to_integer(unsigned(Addr)));
					else
						 Data <= "ZZZZZZZZ";
					end if;
				end if;
		end if;
	end process;
end Behavioral;