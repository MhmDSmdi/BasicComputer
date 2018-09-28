library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity alu is
 Port ( 
     D : inout STD_LOGIC_VECTOR(7 downto 0);
     CF : out STD_LOGIC;
     C : in STD_LOGIC_VECTOR(1 downto 0);
     LE_tmp1 : in STD_LOGIC;
     LE_tmp2 : in STD_LOGIC;
     LE_tmp3 : in STD_LOGIC;
     OE : in STD_LOGIC
 );
end alu;

architecture Behavioral of alu is
signal tmp1 : STD_LOGIC_VECTOR(7 downto 0);
signal tmp2 : STD_LOGIC_VECTOR(7 downto 0);
signal tmp3 : STD_LOGIC_VECTOR(7 downto 0);
signal tmpRESULT : STD_LOGIC_VECTOR(8 downto 0);
begin
process(D,C,LE_tmp1,LE_tmp2,LE_tmp3,OE) 
begin
if(LE_tmp1 = '1') then
tmp1 <= D;
end if;
if(LE_tmp2 = '1') then
tmp2 <= D;
end if;

if(LE_tmp3 = '1') then
case C is
 when "00" => 
 tmpRESULT <= ('0' & tmp1) and  ('0' & tmp2); 
 when "01" =>
 tmpRESULT <= std_logic_vector(unsigned('0' & tmp1) + unsigned('0' & tmp2));
 when "10" => 
 tmpRESULT <= not ('0' & tmp1);
 when "11" => 
 tmpRESULT <= "00" & tmp1(7 downto 1);
 when others => NULL;
end case; 
 end if;
end process;


D <= tmp3 when(OE = '1' and LE_tmp1 = '0' and LE_tmp2 = '0') else "ZZZZZZZZ" ;
tmp3 <= tmpRESULT(7 downto 0);
CF <= tmpRESULT(8) when(C = "01");

end Behavioral;