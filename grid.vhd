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

--types
Type gridArray is array (0 to 7) of std_logic_vector (0 to 15);--(about Y) then (about X)

--signals
signal grid1 : gridArray := (others => (others => '0'));
signal sig : STD_LOGIC;

begin
	process (clk, reset, refreshLife)
	variable nbVoisin : integer := 0;--nombre de voisin de la case centrale
	begin
		IF (clk='1') AND (clk'EVENT) THEN -- TRUE sur un front montant de clk
			if lunchLife = '0' then--parametrage de l'etat initial
				for X in 0 to 15 loop
					for Y in 0 to 7 loop
						if (reset='1') then
							grid1(Y)(X) <= '0';
						elsif (drawEnable='1' and X = to_integer(unsigned(posX(9 downto 6))) and Y = to_integer(unsigned(posY(8 downto 6)))) then
							grid1(Y)(X) <= '1';
						else
							grid1(Y)(X) <= grid1(Y)(X);
						end if;
					end loop;
				end loop;
			else--code pour modifier grid1 selon le jeu de la vie
				for X in 0 to 13 loop
					for Y in 0 to 5 loop
						--on compte le nombre de voisin
						nbVoisin := 0;
						for X1 in 0 to 2 loop
							for Y1 in 0 to 2 loop
								if (grid1(Y+Y1)(X+X1)='1' and not (X1 = 1 and Y1 = 1)) then 
									nbVoisin := nbVoisin +1;
								end if;
							end loop;
						end loop;
						--on modifie la case centrale (Y+1)(X+1)
						if (refreshLife='1' and         reset='1'                      ) then
							grid1(Y+1)(X+1) <= '0';
						elsif (refreshLife='1' and      nbVoisin = 3                   ) then
							grid1(Y+1)(X+1) <= '1';
						elsif (refreshLife='1' and      nbVoisin = 2                   ) then
							grid1(Y+1)(X+1) <= grid1(Y+1)(X+1);
						elsif (refreshLife='1' and     (nbVoisin < 2 or 3 < nbVoisin)  ) then
							grid1(Y+1)(X+1) <= '0';
						end if;
					end loop;
				end loop;
			END IF;
		END IF;
	end process;
	
	sig <= '1' when (grid1(to_integer(unsigned(beamY(8 downto 6))))(to_integer(unsigned(beamX(9 downto 6))))='1' and beamValid='1')
				else '0';


	redOut <= 	'1' when red='1' and sig='1'
					else '0';

	greenOut <= 	'1' when green='1' and sig='1'
					else '0';

	blueOut <= 	'1' when blue='1' and sig='1'
					else '0';


end Behavioral;

