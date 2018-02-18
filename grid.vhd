----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    03:16:55 02/18/2018 
-- Design Name: 
-- Module Name:    grid - Behavioral 
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

entity grid is
    Port ( clk : in  STD_LOGIC;
			  reset : in  STD_LOGIC;
			  beamX : in  STD_LOGIC_VECTOR (9 downto 0);
           beamY : in  STD_LOGIC_VECTOR (9 downto 0);
           beamValid : in  STD_LOGIC;
			  red : in  STD_LOGIC;
           green : in  STD_LOGIC;
           blue : in  STD_LOGIC;
           posX : in  STD_LOGIC_VECTOR (9 downto 0);
           posY : in  STD_LOGIC_VECTOR (9 downto 0);
			  drawEnable : in  STD_LOGIC;
           redOut : out  STD_LOGIC;
           greenOut : out  STD_LOGIC;
           blueOut : out  STD_LOGIC);
end grid;

architecture Behavioral of grid is

--types
Type gridArray is array (0 to 31) of std_logic_vector (0 to 63);--(about Y) then (about X)

--signals
signal grid1 : gridArray := (others => (others => '0'));
signal sig : STD_LOGIC;

begin
	process (clk, posX, posY)
	begin
		IF (clk='1') AND (clk'EVENT) THEN -- TRUE sur un front montant de clk
			for X in 0 to 63 loop
				for Y in 0 to 31 loop
					if (reset='1') then
						grid1(Y)(X) <= '0';
					elsif (drawEnable='1' and X = to_integer(unsigned(posX(9 downto 4))) and Y = to_integer(unsigned(posY(8 downto 4)))) then
						grid1(Y)(X) <= '1';
					else
						grid1(Y)(X) <= grid1(Y)(X);
					end if;
				end loop;
			end loop;
		END IF;
	end process;
	
	sig <= '1' when (grid1(to_integer(unsigned(beamY(8 downto 4))))(to_integer(unsigned(beamX(9 downto 4))))='1' and beamValid='1')
				else '0';


	redOut <= 	'1' when red='1' and sig='1'
					else '0';

	greenOut <= 	'1' when green='1' and sig='1'
					else '0';

	blueOut <= 	'1' when blue='1' and sig='1'
					else '0';


end Behavioral;

