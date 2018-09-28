library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity CU is
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
end CU;
architecture Behavioral of CU is
component decThree is
    Port ( i : in  STD_LOGIC_VECTOR (2 downto 0);
            decout: out STD_LOGIC_VECTOR(7 downto 0)
			  );
end component decThree;

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
signal SEQout : STD_LOGIC_VECTOR(3 downto 0);


signal D : STD_LOGIC_VECTOR(7 downto 0);
signal T : STD_LOGIC_VECTOR(15 downto 0);

begin
threeToEightDec : decThree port map(opcode,d);

seq1: SEQ Port map(CLK,RST,SEQout);
seqDec : decFour Port map(SEQout,T);


-- -- MAR
-- marLE <= (T(0) and D(0)) or (T(0) and D(1)) or (T(0) and D(2)) or (T(0) and D(3)) or (T(0) and D(4)) or (T(0) and D(5));

-- -- PC
-- PC_LE <= (T(3) and D(2)) or (T(3) and D(3) and CF);
-- PC_OE <= (T(0) and D(0)) or (T(0) and D(1)) or (T(0) and D(2)) or (T(0) and D(3)) or (T(0) and D(4)) or (T(0) and D(5));
-- PC_INC <= (T(1) and D(0)) or (T(1) and D(1)) or (T(1) and D(2)) or (T(1) and D(3) and CF) or (T(1) and D(4)) or (T(1) and D(5)) or (T(0) and D(6)) or (T(0) and D(7));


-- -- MDR
-- MDR_OE_IN <=  (T(0) and D(0)) or (T(1) and D(0)) or (T(0) and D(1)) or (T(1) and D(2)) or (T(1) and CF and D(3)) or (T(0) and D(4)) or (T(1) and D(4)) or (T(0) and D(5)) or (T(1) and D(5)) or (T(0) and D(6)) or (T(0) and D(7));
-- MDR_OE_OUT <= T(1) and D(1);
-- MDR_LE_IN <= (T(0) and D(0)) or (T(2) and D(0)) or (T(0) and D(1)) or (T(2) and D(2)) or (T(2) and D(3) and CF) or (T(0) and D(4)) or (T(0) and D(5)) or (T(0) and D(6)) or (T(0) and D(7));
-- MDR_LE_OUT <= T(2) and D(2);


-- -- ACC
-- ACC_LE <= (T(2) and D(0)) or (T(2) and D(4)) or (T(2) and D(5)) or (T(1) and D(6)) or (T(1) and D(7));
-- ACC_OE <= (T(1) and D(1));

-- -- IR
-- IR_LE <= (T(0) and D(0)) or (T(0) and D(1)) or (T(2) and D(2)) or (T(2) and D(3) and CF) or (T(0) and D(4)) or (T(0) and D(5)) or (T(0) and D(6)) or (T(0) and D(7));
-- IR_OE <= (T(1) and D(0)) or (T(1) and D(1)) or (T(3) and D(2)) or (T(3) and D(3) and CF) or (T(1) and D(4)) or (T(1) and D(5));

				marLE <= T(0) or ((D(0) or D(5) or D(4)) and T(2)) or (T(3) and D(1));
				PC_OE <=  T(0);
				PC_LE <= T(2) and (D(2) or (D(3) and CF));
				ramRD <= T(0) or ((D(0) or D(5) or D(4)) and  T(2));
				MDR_LE_OUT <= T(0) or ((D(0) or D(5) or D(4)) and  T(2));
				MDR_OE_OUT <=  (T(3) and D(1));
				IR_LE <= T(1);
				MDR_OE_IN <= T(1) or (D(0) and  T(3)) or (T(3) and (D(5) or D(4)));
				MDR_LE_IN <= T(2) and D(1);
				PC_INC <= T(1);
				IR_OE <= ((D(0) or D(2) or D(5) or D(4) or (D(3) and CF)) and (T(2))) or (D(1) and T(3));
				ACC_LE <= (D(0) and T(3) ) or (T(5) and (D(5) or D(4))) or (T(3) and (D(6) or D(7)));
				aluTMP2le <= (T(3) and (D(5) or D(4)));
				aluTMP1le <= (T(4) and (D(5) or D(4))) or (T(2) and (D(6) or D(7)));
				ACC_OE <= (T(4) and (D(5) or D(4))) or (T(2) and D(1)) or (T(2) and (D(6) or D(7)));
				aluTMP3le <= (T(5) and (D(5) or D(4))) or (T(3) and (D(6) or D(7)));
				aluCONTROL <= "01" when( T(5) = '1' and D(5) = '1') else
				              "00" when( T(5) = '1' and D(4) = '1') else
				              "10" when( T(3) = '1' and D(6) = '1') else
				              "11" when( T(3) = '1' and D(7) = '1');
				aluOE <= (T(5) and (D(5) or D(4))) or (T(3) and (D(6) or D(7)));
				ramWR <= (T(3) and D(1));
end Behavioral;

