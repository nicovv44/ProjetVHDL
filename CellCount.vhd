----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:23:38 03/26/2018 
-- Design Name: 
-- Module Name:    CellCount - Behavioral 
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

entity CellCount is
    Port ( c1 : in  STD_LOGIC;
           c2 : in  STD_LOGIC;
           c3 : in  STD_LOGIC;
           c4 : in  STD_LOGIC;
           c5 : in  STD_LOGIC;
           c6 : in  STD_LOGIC;
           c7 : in  STD_LOGIC;
           c8 : in  STD_LOGIC;
           outLife : out  STD_LOGIC);
end CellCount;

architecture Behavioral of CellCount is

begin
outLife <= c1 or c2 or c3 or c4 or c5 or c6 or c7 or c8;

end Behavioral;

