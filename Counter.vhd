library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TopMd is
    Port ( CLK : in  STD_LOGIC;
            decout: out STD_LOGIC_VECTOR(15 downto 0)
			  );
end TopMd;
architecture Behavioral of TopMd is
component decFour is
    Port ( i : in  STD_LOGIC_VECTOR (3 downto 0);
            decout: out STD_LOGIC_VECTOR(15 downto 0)
			  );
end component decFour;
component SEQ is
    Port ( CLK : in  STD_LOGIC;
           RST : in STD_LOGIC;
           DOUT : out  STD_LOGIC_VECTOR (3 downto 0)
    );

end component SEQ;
signal sigout : STD_LOGIC_VECTOR(3 downto 0);
begin
seq1: SEQ Port map(CLK,'0',sigout);
 dec : decFour Port map(sigout,decout);
end Behavioral;

