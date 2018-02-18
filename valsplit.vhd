----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    19:34:54 01/29/2018 
-- Design Name: 
-- Module Name:    valsplit - Behavioral 
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity valsplit is
    Port ( valin : in  STD_LOGIC_VECTOR (31 downto 0);
           val1 : out  STD_LOGIC_VECTOR (3 downto 0);
           val2 : out  STD_LOGIC_VECTOR (3 downto 0);
           val3 : out  STD_LOGIC_VECTOR (3 downto 0);
           val4 : out  STD_LOGIC_VECTOR (3 downto 0);
           val5 : out  STD_LOGIC_VECTOR (3 downto 0);
           val6 : out  STD_LOGIC_VECTOR (3 downto 0);
           val7 : out  STD_LOGIC_VECTOR (3 downto 0);
           val8 : out  STD_LOGIC_VECTOR (3 downto 0));
end valsplit;

architecture Behavioral of valsplit is

begin
val1 <= valin(31 downto 28);
val2 <= valin(27 downto 24);
val3 <= valin(23 downto 20);
val4 <= valin(19 downto 16);
val5 <= valin(15 downto 12);
val6 <= valin(11 downto  8);
val7 <= valin( 7 downto  4);
val8 <= valin( 3 downto  0);


end Behavioral;

