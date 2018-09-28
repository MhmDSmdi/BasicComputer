library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity decFour is
    Port ( i : in  STD_LOGIC_VECTOR (3 downto 0);
            decout: out STD_LOGIC_VECTOR(15 downto 0)
			  );
end decFour;
architecture Behavioral of decFour is

begin
 process(i)
 begin
		case i is
			 when "0000" => decout <= "0000000000000001";
			 when "0001" => decout <= "0000000000000010";
			 when "0010" => decout <= "0000000000000100";
			 when "0011" => decout <= "0000000000001000";
			 when "0100" => decout <= "0000000000010000";
			 when "0101" => decout <= "0000000000100000";
			 when "0110" => decout <= "0000000001000000";
			 when "0111" => decout <= "0000000010000000";
			 when "1000" => decout <= "0000000100000000";
			 when "1001" => decout <= "0000001000000000";
			 when "1010" => decout <= "0000010000000000";
			 when "1011" => decout <= "0000100000000000";
			 when "1100" => decout <= "0001000000000000";
			 when "1101" => decout <= "0010000000000000";
			 when "1110" => decout <= "0100000000000000";
			 when "1111" => decout <= "1000000000000000";
		
			 when others => null;
		end case;
end process;

end Behavioral;

