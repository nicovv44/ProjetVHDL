----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:32:11 03/26/2018 
-- Design Name: 
-- Module Name:    VALIDATE - Behavioral 
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VALIDATE is
    Port ( reset : in  STD_LOGIC;
			  refreshLife: in std_logic;
           outlifewire : in  STD_LOGIC;
           drawenabled : in  STD_LOGIC;
			  posX : in std_logic;
			  posy : in std_logic;
			  launchlife : in STD_LOGIC;
           result : out  STD_LOGIC);
end VALIDATE;

architecture Behavioral of VALIDATE is

begin

result <= '0' when reset='1' else 
--draw enables
when drawenabled = '1' and posX = '1' and posY = '1' then '1' else
--gol
outlifewire when rising_edge(refreshLife);

end Behavioral;

