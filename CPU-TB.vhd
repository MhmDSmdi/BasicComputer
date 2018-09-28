LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY cputb IS
END cputb;
 
ARCHITECTURE behavior OF cputb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CPU
    Port (  CLK : in  STD_LOGIC;
			RST : in  STD_LOGIC;
			dataBUS : inout STD_LOGIC_VECTOR(7 downto 0);
			WR: out STD_LOGIC;
			RD: out STD_LOGIC
			  );
    END CPU;
    

   signal clk        : std_logic := '0';
   signal RST        : STD_LOGIC;
   signal dataBUS    : STD_LOGIC_VECTOR(7 downto 0);
   signal WR         : STD_LOGIC;
   signal RD         : STD_LOGIC;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CPU PORT MAP (clk,RST,dataBUS,WR,RD);

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for clk_period*10;
      
      dataBUS <= "00001111";
      
      wait for clk_period;

      -- insert stimulus here 

      wait;
   end process;

END;
