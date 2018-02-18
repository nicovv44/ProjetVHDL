----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:30:06 02/17/2018 
-- Design Name: 
-- Module Name:    clkDiv - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clkDiv is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           valDiv : in  STD_LOGIC_VECTOR (31 downto 0);
           clkd : inout  STD_LOGIC);--toogle beetwen 0 and 1 each valDiv clock tick
end clkDiv;

architecture Behavioral of clkDiv is

--signals
signal val : STD_LOGIC_VECTOR (31 downto 0);
signal valMux : STD_LOGIC_VECTOR (31 downto 0);
signal overflow : STD_LOGIC;
signal clkdMux : STD_LOGIC;

begin
val <= (OTHERS => '0') when reset='1'
			else valMux when rising_edge(clk);

valMux <= (others => '0') when overflow='1'
			else  std_logic_vector(unsigned(val)+1);

overflow <= '1' when val>valDiv else '0';

clkdMux <= (not clkd) when overflow='1'
			else  clkd;

clkd <= '0' when reset='1'
			else clkdMux when rising_edge(clk);

end Behavioral;

