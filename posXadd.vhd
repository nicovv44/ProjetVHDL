----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:07:31 01/29/2018 
-- Design Name: 
-- Module Name:    posXadd - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity posXadd is
    Port ( posXin : in  STD_LOGIC_VECTOR (9 downto 0);
           posX2 : out  STD_LOGIC_VECTOR (9 downto 0);
           posX3 : out  STD_LOGIC_VECTOR (9 downto 0);
           posX4 : out  STD_LOGIC_VECTOR (9 downto 0);
           posX5 : out  STD_LOGIC_VECTOR (9 downto 0);
           posX6 : out  STD_LOGIC_VECTOR (9 downto 0);
			  posX7 : out  STD_LOGIC_VECTOR (9 downto 0);
           posX8 : out  STD_LOGIC_VECTOR (9 downto 0));
end posXadd;

architecture Behavioral of posXadd is

constant step : integer := 10;

begin
posX2 <= posXin + 1*step;
posX3 <= posXin + 2*step;
posX4 <= posXin + 3*step;
posX5 <= posXin + 4*step;
posX6 <= posXin + 5*step;
posX7 <= posXin + 6*step;
posX8 <= posXin + 7*step;


end Behavioral;

