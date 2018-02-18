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
           redOut : out  STD_LOGIC;
           greenOut : out  STD_LOGIC;
           blueOut : out  STD_LOGIC);
end grid;

architecture Behavioral of grid is

--types
Type gridArray is array (0 to 31) of std_logic_vector (0 to 31);--32*32 matrix

--signals
signal grid1 : gridArray := (others => (others => '0'));
signal sig : STD_LOGIC;
signal gridBeamX : STD_LOGIC_VECTOR (4 downto 0);
signal gridBeamY : STD_LOGIC_VECTOR (4 downto 0);

begin
	--grid1(to_integer(unsigned(posY(3 downto 0))))(to_integer(unsigned(posX(3 downto 0)))) <= '1';

	--grid1(to_integer(unsigned(posY)))(to_integer(unsigned(posX))) <= '1';
	--grid1 <= (others => (others => '0')) when reset='1';
	
	process (posX, posY)
	begin
		for X in 0 to 31 loop
			for Y in 0 to 31 loop
				if (reset='1') then
					grid1(Y)(X) <= '0';
				elsif (X = to_integer(unsigned(posX(9 downto 5))) and Y = to_integer(unsigned(posY(9 downto 5)))) then
					grid1(Y)(X) <= '1';
				else
					grid1(Y)(X) <= grid1(Y)(X);
				end if;
			end loop;
		end loop;
	end process;
	
	gridBeamX <= beamX(9 downto 5);--we divide beamX by 32 to fill gridBeamX
	gridBeamY <= beamY(9 downto 5);
	
	sig <= '1' when (grid1(to_integer(unsigned(gridBeamY)))(to_integer(unsigned(gridBeamX)))='1' and beamValid='1')
				else '0';


	redOut <= 	'1' when red='1' and sig='1'
					else '0';

	greenOut <= 	'1' when green='1' and sig='1'
					else '0';

	blueOut <= 	'1' when blue='1' and sig='1'
					else '0';


end Behavioral;

