library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity CPU is
    Port (  CLK : in  STD_LOGIC;
			RST : in  STD_LOGIC;
			dataBUS : inout STD_LOGIC_VECTOR(7 downto 0);
			addressBUS : out STD_LOGIC_VECTOR(4 downto 0);
			WR: out STD_LOGIC;
			RD: out STD_LOGIC
			  );
end CPU;
architecture Behavioral of CPU is
component alu is
 Port ( 
     D : inout STD_LOGIC_VECTOR(7 downto 0);
     CF : out STD_LOGIC;
     C : in STD_LOGIC_VECTOR(1 downto 0);
     LE_tmp1 : in STD_LOGIC;
     LE_tmp2 : in STD_LOGIC;
     LE_tmp3 : in STD_LOGIC;
     OE : in STD_LOGIC
 );
end component alu;

component ACC is
     Port ( D : inout  STD_LOGIC_VECTOR (7 downto 0);
           LE : in  STD_LOGIC;
           OE : in  STD_LOGIC
			  );
end component ACC;

component PC is
        Port ( 
           D : inout  STD_LOGIC_VECTOR (7 downto 0);
           LE : in  STD_LOGIC;
           OE : in  STD_LOGIC;
           CLR : in  STD_LOGIC;
           CLK : in  STD_LOGIC;
           INC : in  STD_LOGIC
			  );
end component PC;

component MAR is
    Port ( D : in  STD_LOGIC_VECTOR (7 downto 0);
           A : out  STD_LOGIC_VECTOR (4 downto 0);
           LE : in  STD_LOGIC
			  );
end component MAR;

component MDR is
       Port ( DIN : inout  STD_LOGIC_VECTOR (7 downto 0);
           DOUT : inout  STD_LOGIC_VECTOR (7 downto 0);
           LE_IN : in  STD_LOGIC;
           LE_OUT : in  STD_LOGIC;
           OE_IN : in  STD_LOGIC;
           OE_OUT : in  STD_LOGIC
		   );
end component MDR;

component IR is
    Port ( D : inout  STD_LOGIC_VECTOR (7 downto 0);
           LE : in  STD_LOGIC;
           OE : in  STD_LOGIC;
           I : out  STD_LOGIC_VECTOR(2 downto 0)
		   );
end component IR;
component CU is
    Port (  opcode : in  STD_LOGIC_VECTOR (2 downto 0);
            CLK : in  STD_LOGIC;
            RST : in  STD_LOGIC;
            CF : in  STD_LOGIC;
			marLE : out STD_LOGIC;
			PC_LE : out STD_LOGIC;
			PC_OE : out STD_LOGIC;
			PC_INC : out STD_LOGIC;
			MDR_OE_IN : out STD_LOGIC;
			MDR_OE_OUT : out STD_LOGIC;
			MDR_LE_IN : out STD_LOGIC;
			MDR_LE_OUT : out STD_LOGIC;
			ACC_LE : out STD_LOGIC;
			ACC_OE : out STD_LOGIC;
			IR_LE : out STD_LOGIC;
			IR_OE : out STD_LOGIC;
			ramRD : out STD_LOGIC;
			ramWR : out STD_LOGIC;
			aluTMP1le : out STD_LOGIC;
			aluTMP2le : out STD_LOGIC;
			aluTMP3le : out STD_LOGIC;
			aluOE : out STD_LOGIC;
			aluCONTROL : out STD_LOGIC_VECTOR(1 downto 0)
			  );
end component CU;

signal internalBUS : STD_LOGIC_VECTOR(7 downto 0);

signal CFsig : STD_LOGIC;
signal aluControlSig : STD_LOGIC_VECTOR(1 downto 0);
signal tmp1Sig : STD_LOGIC;
signal tmp2Sig : STD_LOGIC;
signal tmp3Sig : STD_LOGIC;
signal aluOE : STD_LOGIC;


signal accLE : STD_LOGIC;
signal accOE : STD_LOGIC;

signal pcLE : STD_LOGIC := '0';
signal pcOE : STD_LOGIC := '0';
signal pcCLR : STD_LOGIC;
signal pcINC : STD_LOGIC;

-- signal marA : STD_LOGIC_VECTOR(4 downto 0);
signal marLE : STD_LOGIC;

--signal mdrDIN : STD_LOGIC_VECTOR(7 downto 0);
--signal mdrDOUT : STD_LOGIC_VECTOR(7 downto 0);
signal mdrLEIN : STD_LOGIC;
signal mdrLEOUT : STD_LOGIC;
signal mdrOEIN : STD_LOGIC;
signal mdrOEOUT : STD_LOGIC;


signal irLE : STD_LOGIC;
signal irOE : STD_LOGIC;
signal irI : STD_LOGIC_VECTOR(2 downto 0);
begin
pcCLR <= RST;
myALU : alu port map(internalBUS,CFsig,aluControlSig,tmp1Sig,tmp2Sig,tmp3Sig,aluOE);
myACC : ACC port map(internalBUS,accLE,accOE);
myPC : PC port map(internalBUS,pcLE,pcOE,pcCLR,CLK,pcINC);
myMAR : MAR port map(internalBUS,addressBUS,marLE);
myMDR : MDR port map(internalBUS,dataBUS,mdrLEIN,mdrLEOUT,mdrOEIN,mdrOEOUT);
myIR : IR port map(internalBUS,irLE,irOE,irI);

myCU : CU port map(irI,CLK,RST,CFsig,marLE,pcLE,pcOE,pcINC,mdrOEIN,mdrOEOUT,mdrLEIN,mdrLEOUT,accLE,accOE,irLE,irOE,RD,WR,tmp1Sig,tmp2Sig,tmp3Sig,aluOE,aluControlSig);
end Behavioral;

