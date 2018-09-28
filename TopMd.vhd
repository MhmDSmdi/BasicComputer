library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity TopMd is
    Port ( CLK : in  STD_LOGIC;
			RST : in STD_LOGIC  := '1';
			IOoneOUT : out STD_LOGIC_VECTOR(7 downto 0);
			IOtwoIN : in STD_LOGIC_VECTOR(7 downto 0);
			IOthreeINPandOUTPUT : inout STD_LOGIC_VECTOR(7 downto 0)
			  );
end TopMd;
architecture Behavioral of TopMd is

signal addressBUS : STD_LOGIC_VECTOR(4 downto 0);
signal dataBUS : STD_LOGIC_VECTOR(7 downto 0);
signal WR : STD_LOGIC;
signal RD : STD_LOGIC;

signal csRAM : STD_LOGIC;
signal csROM : STD_LOGIC;
signal csIO0 : STD_LOGIC;
signal csIO1 : STD_LOGIC;
signal csIO2 : STD_LOGIC;
component CPU is
      Port (  CLK : in  STD_LOGIC;
			RST : in  STD_LOGIC;
			dataBUS : inout STD_LOGIC_VECTOR(7 downto 0);
			addressBUS : out STD_LOGIC_VECTOR(4 downto 0);
			WR: out STD_LOGIC;
			RD: out STD_LOGIC
			  );
end component CPU;
component memDec is
    Port ( i : in  STD_LOGIC_VECTOR (4 downto 0);
           csROM : out  STD_LOGIC := '0';
		   csRAM : out  STD_LOGIC := '0';
           csIO0 : out  STD_LOGIC := '0';
           csIO1 : out  STD_LOGIC := '0';
           csIO2 : out  STD_LOGIC := '0'
		   			  );
end component memDec;
component singleram is
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
end component singleram;
component rom is
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
        Reset 	: in  STD_LOGIC := '0';
		cs		: in STD_LOGIC ;
		Data 	: out STD_LOGIC_VECTOR (MEMORY_WIDTH - 1 downto 0);
		Addr	: in  STD_LOGIC_VECTOR (ADDRESS_WIDTH - 1 downto 0);
		RD	: in  STD_LOGIC
	);
end component rom;
component IO is
    Port ( 
           kINBUS : in  STD_LOGIC_VECTOR (7 downto 0);
           kOUT : out  STD_LOGIC_VECTOR (7 downto 0);
		   vIN : in  STD_LOGIC_VECTOR (7 downto 0);
	       vOUTBUS : out  STD_LOGIC_VECTOR (7 downto 0);
           VK : inout  STD_LOGIC_VECTOR (7 downto 0);
           VKBUS : inout  STD_LOGIC_VECTOR (7 downto 0);
		   	  csK : in  STD_LOGIC;
			  wrK : in  STD_LOGIC;
			  csV : in  STD_LOGIC;
			  rdV : in  STD_LOGIC;
			  csVK : in  STD_LOGIC;
			  rdVK : in  STD_LOGIC;
			  wrVK : in  STD_LOGIC
			  );
end component IO;

begin
topCPU : CPU Port map (CLK,RST,dataBUS,addressBUS,WR,RD);
topMemDec : memDec Port map(addressBUS,csROM,csRAM,csIO0,csIO1,csIO2);
topRAM : singleram Port map(CLK,RST,csRAM,dataBUS,addressBUS(2 downto 0),WR,RD);
topROM : rom Port map(CLK,RST,csROM,dataBUS,addressBUS(3 downto 0),RD);
topIO : IO Port map(dataBUS,IOoneOUT,IOtwoIN,dataBUS,IOthreeINPandOUTPUT,dataBUS,csIO0,WR,csIO1,RD,csIO2,RD,WR);
end Behavioral;

