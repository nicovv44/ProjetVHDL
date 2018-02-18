----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:31:23 01/31/2018 
-- Design Name: 
-- Module Name:    valInc - Behavioral 
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

entity valInc is
    Port ( clk50 : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  zero : in STD_LOGIC;
           val : inout  STD_LOGIC_VECTOR (31 downto 0));
end valInc;

architecture Behavioral of valInc is
signal valNext     : std_logic_vector(31 downto 0);
signal valNextNext  : std_logic_vector(31 downto 0);
signal cpthsup50M : std_logic;
signal val_mux : std_logic_vector(31 downto 0);

begin
cpthsup50M <= '1' when unsigned(valNext)>=50000000 else '0';

valNextNext <= (others => '0') when cpthsup50M='1'
           else  std_logic_vector(unsigned(valNext)+1);
			  
valNext <= (others => '0') when reset='1'
        else valNextNext when rising_edge(clk50);

val <= (others => '0') when (reset='1' or zero='1')
			else val_mux when rising_edge (clk50);

val_mux <= std_logic_vector(unsigned(val)+1) when cpthsup50M='1'
			else val;

end Behavioral;

