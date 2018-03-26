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
			  lunchLife : in STD_LOGIC;
			  refreshLife : in STD_LOGIC;
           redOut : out  STD_LOGIC;
           greenOut : out  STD_LOGIC;
           blueOut : out  STD_LOGIC);
end grid;

architecture Behavioral of grid is

--components
component CellCount is
	Port ( c1 : in  STD_LOGIC;
           c2 : in  STD_LOGIC;
           c3 : in  STD_LOGIC;
           c4 : in  STD_LOGIC;
           c5 : in  STD_LOGIC;
           c6 : in  STD_LOGIC;
           c7 : in  STD_LOGIC;
           c8 : in  STD_LOGIC;
           outLife : out  STD_LOGIC);
end component;

--types
Type gridArray is array (0 to 7) of std_logic_vector (0 to 15);--(about Y) then (about X)
--Type gridArrayVoisin is array (0 to 7) of gridArray;

--signals
signal grid1 : gridArray := (others => (others => '0'));
--signal grid2 : gridArrayVoisin := (others => (others => (others => '0')));
signal sig : STD_LOGIC;
signal outLifeWire : STD_LOGIC := '0';

begin
--	process (clk)
--	variable nbVoisin : integer := 0;--nombre de voisin de la case centrale
--	begin
--		IF (clk='1') AND (clk'EVENT) THEN -- TRUE sur un front montant de clk
--			if lunchLife = '0' then--parametrage de l'etat initial
--				for X in 0 to 15 loop
--					for Y in 0 to 7 loop
--						if (reset='1') then
--							grid1(Y)(X) <= '0';
--						elsif (drawEnable='1' and X = to_integer(unsigned(posX(9 downto 6))) and Y = to_integer(unsigned(posY(8 downto 6)))) then
--							grid1(Y)(X) <= '1';
--						else
--							grid1(Y)(X) <= grid1(Y)(X);
--						end if;
--					end loop;
--				end loop;
--			END IF;
--		END IF;
--	end process;
	

	OUTERLOOP: FOR x IN 0 TO 15 GENERATE--horizontal
		OUTERLOOP2: FOR y IN 0 TO 7 GENERATE--vertical
			INNERLOOP1: IF (x = 1 and y = 1) GENERATE--case0
				CELLCOUNT: CellCount PORT MAP(c1 => grid1(y-1)(x-1),
														c2 => grid1(y-1)(x  ),
														c3 => grid1(y-1)(x+1),
														c4 => grid1(y  )(x-1),
														c5 => grid1(y  )(x+1),
														c6 => grid1(y+1)(x-1),
														c7 => grid1(y+1)(x  ),
														c8 => grid1(y+1)(x+1),
														outLife => outLifeWire
														);
				VALIDATE : Validate PORT MAP(reset => reset, 
														refreshLife => refreshLife,
														outlifewire => outLifeWire,
														drawenabled =>drawEnable,
														posX => posX(x),
														posy => poxY(y),
														launchlife => lunchLife,
														result => grid1(y)(x)
														);
				--grid1(y)(x) <= '0' when reset='1' else
					--			outLifeWire when rising_edge(refreshLife);
			END GENERATE INNERLOOP1;
			INNERLOOP2: IF (x = 2 and y = 1) GENERATE--case1
				--
			END GENERATE INNERLOOP2;
		END GENERATE OUTERLOOP2;
	END GENERATE OUTERLOOP;

	sig <= '1' when (grid1(to_integer(unsigned(beamY(8 downto 6))))(to_integer(unsigned(beamX(9 downto 6))))='1' and beamValid='1')
				else '0';


	redOut <= 	'1' when red='1' and sig='1'
					else '0';

	greenOut <= 	'1' when green='1' and sig='1'
					else '0';

	blueOut <= 	'1' when blue='1' and sig='1'
					else '0';


end Behavioral;

