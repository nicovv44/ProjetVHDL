----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:20:48 02/03/2018 
-- Design Name: 
-- Module Name:    TOP4 - Behavioral 
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

entity TOP is
    Port ( clk50 : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  posXP : in  STD_LOGIC;
			  posXM : in  STD_LOGIC;
			  posYP : in  STD_LOGIC;
			  posYM : in  STD_LOGIC;
			  freeMove : in STD_LOGIC;
			  zero : in STD_LOGIC;
			  subValSelect : in STD_LOGIC;
           red : out  STD_LOGIC;
           green : out  STD_LOGIC;
           blue : out  STD_LOGIC;
           hsync : out  STD_LOGIC;
           vsync : out  STD_LOGIC;
           blank : inout  STD_LOGIC);
end TOP;

architecture Behavioral of TOP is
component Hex32 is
	Port ( val : in  STD_LOGIC_VECTOR (31 downto 0);
           posX : in  STD_LOGIC_VECTOR (9 downto 0);
           posY : in  STD_LOGIC_VECTOR (9 downto 0);
           red : in  STD_LOGIC;
           green : in  STD_LOGIC;
           blue : in  STD_LOGIC;
           beamX : in  STD_LOGIC_VECTOR (9 downto 0);
           beamY : in  STD_LOGIC_VECTOR (9 downto 0);
           beamValid : in  STD_LOGIC;
           redOut : out  STD_LOGIC;
           greenOut : out  STD_LOGIC;
           blueOut : out  STD_LOGIC);
end component;
component controlVGA is
	Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           rIn : in  STD_LOGIC;
           gIn : in  STD_LOGIC;
           bIn : in  STD_LOGIC;
           rOut : out  STD_LOGIC;
           gOut : out  STD_LOGIC;
           bOut : out  STD_LOGIC;
           beamX : out  STD_LOGIC_VECTOR (9 downto 0);
           beamY : out  STD_LOGIC_VECTOR (9 downto 0);
           beamValid : out  STD_LOGIC;
           blank : inout  STD_LOGIC;
           vsync : out  STD_LOGIC;
           hsync : out  STD_LOGIC);
end component;
component valInc is
	Port ( clk50 : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  zero : in STD_LOGIC;
           val : inout  STD_LOGIC_VECTOR (31 downto 0));
end component;
component move is
	Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           posX : inout  STD_LOGIC_VECTOR (9 downto 0);
           posY : inout  STD_LOGIC_VECTOR (9 downto 0);
			  posXP : in  STD_LOGIC;
			  posXM : in  STD_LOGIC;
			  posYP : in  STD_LOGIC;
			  posYM : in  STD_LOGIC;
			  subValSelect : in  STD_LOGIC;
			  freeMove : in  STD_LOGIC);
end component;
component shapes is
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
end component;
signal beamXBus : std_logic_VECTOR (9 downto 0);
signal beamYBus : std_logic_VECTOR (9 downto 0);
signal beamValidWire : std_logic;
signal redWire : std_logic;--going to ControlVGA
signal greenWire : std_logic;
signal blueWire : std_logic;
signal redShapes : std_logic;--outing from Shapes
signal greenShapes : std_logic;
signal blueShapes : std_logic;
signal redHex32 : std_logic;--outing from Hex32
signal greenHex32 : std_logic;
signal blueHex32 : std_logic;
--constants
signal constRed1 : std_logic;
signal constGreen1 : std_logic;
signal constBlue1 : std_logic;
signal valWire : std_logic_vector(31 downto 0);
signal posXWire : std_logic_vector(9 downto 0);--go to Hex32
signal posYWire : std_logic_vector(9 downto 0);
signal posXWire2 : std_logic_vector(9 downto 0);--go to Shapes
signal posYWire2 : std_logic_vector(9 downto 0);

begin
		--init constants
		constRed1 <= '1';
		constGreen1 <= '1';
		constBlue1 <= '1';
		--gathering colors to send to ControlVGA
		redWire <= redHex32 or redShapes;
		greenWire <= greenHex32 or greenShapes;
		blueWire <= blueHex32 or blueShapes;
		--instances
		SHAPES1 : shapes port map(
									--in
									clk => clk50,
									reset => reset,
									beamX => beamXBus,
									beamY => beamYBus,
									beamValid => beamValidWire,
									posX => posXWire2,
									posY => posYWire2,
									--out
									red => redShapes,
									green => greenShapes,
									blue => blueShapes
									);
		MOVE1 : move port map(--to move the chrono
									--in
									clk => clk50,
									reset => reset,
									posXP => '0',
									posXM => '0',
									posYP => '0',
									posYM => '0',
									subValSelect => subValSelect,
									freeMove => freeMove,
									--out
									posX => posXWire,
									posY => posYWire
									);
		MOVE2 : move port map(--to move the cursor
									--in
									clk => clk50,
									reset => reset,
									posXP => posXP,
									posXM => posXM,
									posYP => posYP,
									posYM => posYM,
									subValSelect => subValSelect,
									freeMove => freeMove,
									--out
									posX => posXWire2,
									posY => posYWire2
									);
		VALINC1 : valInc port map(
									--in
									clk50 => clk50,
									reset => reset,
									zero => zero,
									--out
									val => valWire
									);
		HEX321 : Hex32 port map(
									--in
									val => valWire,
									posX => posXWire,
									posY => posYWire,
									red => constRed1,
									green => constGreen1,
									blue => constBlue1,
									beamX => beamXBus,
									beamY => beamYBus,
									beamValid => beamValidWire,
									--out
									redOut => redHex32,
									greenOut => greenHex32,
									blueOut => blueHex32
									);
		CONTROLVGA1 : controlVGA port map (
									--in
									clk => clk50 ,
									reset => reset,
									rIn => redWire,
									gIn => greenWire,
									bIn => blueWire,
									--out
									beamX => beamXBus,
									beamY => beamYBus, 
									beamValid => beamValidWire,
									rOut =>  red,
									gOut =>  green,
									bOut =>  blue,
									vsync => vsync,
									hsync => hsync,
									blank => blank
									);


end Behavioral;