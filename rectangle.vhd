----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:58:59 02/17/2018 
-- Design Name: 
-- Module Name:    shape - Behavioral 
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

entity rectangle is
    Port ( beamX : in  STD_LOGIC_VECTOR (9 downto 0);
           beamY : in  STD_LOGIC_VECTOR (9 downto 0);
           beamValid : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           red : in  STD_LOGIC;
           green : in  STD_LOGIC;
           blue : in  STD_LOGIC;
           minX : in  STD_LOGIC_VECTOR (9 downto 0);
           minY : in  STD_LOGIC_VECTOR (9 downto 0);
           maxX : in  STD_LOGIC_VECTOR (9 downto 0);
           maxY : in  STD_LOGIC_VECTOR (9 downto 0);
           redOut : out  STD_LOGIC;
           greenOut : out  STD_LOGIC;
           blueOut : out  STD_LOGIC);
end rectangle;

architecture Behavioral of rectangle is

--signals
signal sig : STD_LOGIC;

begin
sig <= '1' when (beamX>minX and beamX<maxX and beamY>minY and beamY<maxY and beamValid='1')
				else '0';


redOut <= 	'1' when red='1' and sig='1' and enable='1'
				else '0';

greenOut <= 	'1' when green='1' and sig='1' and enable='1'
				else '0';

blueOut <= 	'1' when blue='1' and sig='1' and enable='1'
				else '0';

end Behavioral;

