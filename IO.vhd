library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity IO is
    Port ( 
           kINBUS : in  STD_LOGIC_VECTOR (7 downto 0);
           kOUT : out  STD_LOGIC_VECTOR (7 downto 0) := "ZZZZZZZZ";
		   vIN : in  STD_LOGIC_VECTOR (7 downto 0);
	       vOUTBUS : out  STD_LOGIC_VECTOR (7 downto 0) := "ZZZZZZZZ";
           VK : inout  STD_LOGIC_VECTOR (7 downto 0) := "ZZZZZZZZ";
           VKBUS : inout  STD_LOGIC_VECTOR (7 downto 0) := "ZZZZZZZZ";
		   	  csK : in  STD_LOGIC;
			  wrK : in  STD_LOGIC;
			  csV : in  STD_LOGIC;
			  rdV : in  STD_LOGIC;
			  csVK : in  STD_LOGIC;
			  rdVK : in  STD_LOGIC;
			  wrVK : in  STD_LOGIC
			  );
end IO;

architecture Behavioral of IO is
begin
		process(csV ,rdV)
		begin
			if (csV = '1' and rdV = '1') then 
				vOUTBUS <= vIN;
			else
				vOUTBUS <= "ZZZZZZZZ";
			end if;
		end process;

		process(csK ,wrK)
		begin
			if (csK = '1' and wrK = '1') then 
				kOUT <= kINBUS;
			end if;
		end process;

		process(csVK , rdVK, wrVK)
		begin
			if (csVK = '1') then 
				if (rdVK = '1') then 
					VKBUS <= VK;
				else
				  VKBUS <= "ZZZZZZZZ";
			   end if;
				if (wrVK = '1') then 
					VK <= VKBUS;
			   end if;
			else
			 VKBUS <= "ZZZZZZZZ";
			end if;
		end process;

end Behavioral;

