----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:53:16 02/16/2018 
-- Design Name: 
-- Module Name:    clkSub - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;--so + is understoud
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity clkSub is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  subVal : in  STD_LOGIC_VECTOR (25 downto 0);
           clks : out  STD_LOGIC);--give 1 during half a clock cycle, each subVal clock tick
end clkSub;

architecture Behavioral of clkSub is

--signals
signal val     : std_logic_vector(25 downto 0);
signal valMux  : std_logic_vector(25 downto 0);
signal flag :std_logic;

begin
flag <= '1' when val = subVal else '0';

valMux <= (others => '0') when flag='1'
           else  std_logic_vector(unsigned(val)+1);   

val <= (others => '0') when reset='1'
        else valMux when rising_edge(clk);

clks <= '0' when reset='1'
        else flag when rising_edge(clk);

end Behavioral;

