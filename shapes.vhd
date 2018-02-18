----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:40:00 02/17/2018 
-- Design Name: 
-- Module Name:    shapes - Behavioral 
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

entity shapes is
    Port ( clk : in  STD_LOGIC;
				reset : in  STD_LOGIC;
				beamX : in  STD_LOGIC_VECTOR (9 downto 0);
				beamY : in  STD_LOGIC_VECTOR (9 downto 0);
				beamValid : in  STD_LOGIC;
				posX : in  STD_LOGIC_VECTOR (9 downto 0);
				posY : in  STD_LOGIC_VECTOR (9 downto 0);
				red : out  STD_LOGIC;
				green : out  STD_LOGIC;
				blue : out  STD_LOGIC);
end shapes;

architecture Behavioral of shapes is

--components
component rectangle is
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
end component;
component clkDiv is
	Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           valDiv : in  STD_LOGIC_VECTOR (31 downto 0);
           clkd : inout  STD_LOGIC);
end component;
component mover is
	Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  posReset : in  STD_LOGIC_VECTOR (9 downto 0);
			  posMin : in  STD_LOGIC_VECTOR (9 downto 0);
			  posMax : in  STD_LOGIC_VECTOR (9 downto 0);
			  posP : in  STD_LOGIC;
			  posM : in  STD_LOGIC;
			  subValSelect : in  STD_LOGIC;
           pos : inout  STD_LOGIC_VECTOR (9 downto 0));
end component;

--signals
--to all rectangles
signal   enable : STD_LOGIC;
--to   RECTANGLE1
signal maxX1 : STD_LOGIC_VECTOR (9 downto 0);
signal maxY1 : STD_LOGIC_VECTOR (9 downto 0);
--from RECTANGLE1
signal   redOut1 : STD_LOGIC;
signal greenOut1 : STD_LOGIC;
signal  blueOut1 : STD_LOGIC;

begin
	--gathering colors to send out of shapes
	red <=     redOut1;
	green <= greenOut1;
	blue <=   blueOut1;
	
	--instances
	--to make Rectangles blink
	CLKDIV3 : clkDiv port map(
							--in
							clk => clk,
							reset => reset,
							valDiv => std_logic_vector(to_unsigned(2000000, 32)),--on 32bits
							--out
							clkd => enable
							);
	--RECTANGLE1
	maxX1 <= std_logic_vector(unsigned(posX)+5);--horizontal size of the rectangle if after +
	maxY1 <= std_logic_vector(unsigned(posY)+5);--vertical size of the rectangle if after +
	RECTANGLE1 : rectangle port map(
								--in
								beamX => beamX,
								beamY => beamY,
								beamValid => beamValid,
								enable => enable,--on 1bit, displayed or not
								red => '1',--colors of she shape
								green => '1',
								blue => '1',
								minX => posX,--on 10bits
								minY => posY,--on 10bits
								maxX => maxX1,--on 10bits
								maxY => maxY1,--on 10bits
								--out
								redOut => redOut1,
								greenOut => greenOut1,
								blueOut => blueOut1
								);
	
end Behavioral;

