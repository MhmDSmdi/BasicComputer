library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity decThree is
    Port ( i : in  STD_LOGIC_VECTOR (2 downto 0);
            decout: out STD_LOGIC_VECTOR(7 downto 0)
			  );
end decThree;
architecture Behavioral of decThree is

begin
 process(i)
 begin
		case i is
			 when "000" => decout <= "00000001";
			 when "001" => decout <= "00000010";
			 when "010" => decout <= "00000100";
			 when "011" => decout <= "00001000";
			 when "100" => decout <= "00010000";
			 when "101" => decout <= "00100000";
			 when "110" => decout <= "01000000";
			 when "111" => decout <= "10000000";
			 when others => null;
		end case;
end process;

end Behavioral;

