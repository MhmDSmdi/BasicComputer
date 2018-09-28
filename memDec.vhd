
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity memDec is
    Port ( i : in  STD_LOGIC_VECTOR (4 downto 0);
           csROM : out  STD_LOGIC := '0';
		   csRAM : out  STD_LOGIC := '0';
           csIO0 : out  STD_LOGIC := '0';
           csIO1 : out  STD_LOGIC := '0';
           csIO2 : out  STD_LOGIC := '0'
		   			  );
end memDec;
architecture Behavioral of memDec is
signal decout : STD_LOGIC_VECTOR (31 downto 0);

begin
 process(i)
 begin
		case i is
			 when "00000" => decout <= "00000000000000000000000000000001";
			 when "00001" => decout <= "00000000000000000000000000000010";
			 when "00010" => decout <= "00000000000000000000000000000100";
			 when "00011" => decout <= "00000000000000000000000000001000";
			 when "00100" => decout <= "00000000000000000000000000010000";
			 when "00101" => decout <= "00000000000000000000000000100000";
			 when "00110" => decout <= "00000000000000000000000001000000";
			 when "00111" => decout <= "00000000000000000000000010000000";
			 when "01000" => decout <= "00000000000000000000000100000000";
			 when "01001" => decout <= "00000000000000000000001000000000";
			 when "01010" => decout <= "00000000000000000000010000000000";
			 when "01011" => decout <= "00000000000000000000100000000000";
			 when "01100" => decout <= "00000000000000000001000000000000";
			 when "01101" => decout <= "00000000000000000010000000000000";
			 when "01110" => decout <= "00000000000000000100000000000000";
			 when "01111" => decout <= "00000000000000001000000000000000";
			 when "10000" => decout <= "00000000000000010000000000000000";
			 when "10001" => decout <= "00000000000000100000000000000000";
			 when "10010" => decout <= "00000000000001000000000000000000";
			 when "10011" => decout <= "00000000000010000000000000000000";
			 when "10100" => decout <= "00000000000100000000000000000000";
			 when "10101" => decout <= "00000000001000000000000000000000";
			 when "10110" => decout <= "00000000010000000000000000000000";
			 when "10111" => decout <= "00000000100000000000000000000000";
			 when "11000" => decout <= "00000001000000000000000000000000";
			 when "11001" => decout <= "00000010000000000000000000000000";
			 when "11010" => decout <= "00000100000000000000000000000000";
			 when "11011" => decout <= "00001000000000000000000000000000";
			 when "11100" => decout <= "00010000000000000000000000000000";
			 when "11101" => decout <= "00100000000000000000000000000000";
			 when "11110" => decout <= "01000000000000000000000000000000";
			 when "11111" => decout <= "10000000000000000000000000000000";
			 when others => null;
		end case;
end process;

csROM <= decout(0) or
decout(1) or
decout(2) or
decout(3) or
decout(4) or
decout(5) or
decout(6) or
decout(7) or
decout(8) or
decout(9) or
decout(10) or
decout(11) or
decout(12) or
decout(13) or
decout(14) or
decout(15);

csRAM <= decout(16) or
decout(17) or
decout(18) or
decout(19) or
decout(20) or
decout(21) or
decout(22) or
decout(23);


csIO0 <= decout(29);
csIO1 <= decout(30);
csIO2 <= decout(31);
end Behavioral;

