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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity validate is
    Port ( reset : in  STD_LOGIC;
			  refreshLife: in std_logic;
           life : in  STD_LOGIC;
           drawEnable : in  STD_LOGIC;
			  posX : in  STD_LOGIC_VECTOR (9 downto 0);
           posY : in  STD_LOGIC_VECTOR (9 downto 0);
			  X : in  STD_LOGIC_VECTOR (9 downto 0);
			  Y : in  STD_LOGIC_VECTOR (9 downto 0);
			  lunchLife : in STD_LOGIC;
           result : out  STD_LOGIC);
end validate;

architecture Behavioral of validate is

begin
result <= '0' when reset='1'
			else '1' when (lunchLife='0' and drawEnable='1' and X(9 downto 6)=posX(9 downto 6) and Y(8 downto 6)=posY(8 downto 6) )
			else life when rising_edge(refreshLife);

end Behavioral;

