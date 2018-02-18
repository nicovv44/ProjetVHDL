----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    08:33:42 01/29/2018 
-- Design Name: 
-- Module Name:    Hex32 - Behavioral 
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

entity Hex32 is
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
end Hex32;

architecture Behavioral of Hex32 is
component digit is
	Port ( val : in  STD_LOGIC_VECTOR (3 downto 0);
           posX : in  STD_LOGIC_VECTOR (9 downto 0);
           posY : in  STD_LOGIC_VECTOR (9 downto 0);
           beamX : in  STD_LOGIC_VECTOR (9 downto 0);
           beamY : in  STD_LOGIC_VECTOR (9 downto 0);
           beamValid : in  STD_LOGIC;
           red : in  STD_LOGIC;
           green : in  STD_LOGIC;
           blue : in  STD_LOGIC;
           redOut : out  STD_LOGIC;
           greenOut : out  STD_LOGIC;
           blueOut : out  STD_LOGIC);
end component;
component posXadd is
	Port ( posXin : in  STD_LOGIC_VECTOR (9 downto 0);
           posX2 : out  STD_LOGIC_VECTOR (9 downto 0);
           posX3 : out  STD_LOGIC_VECTOR (9 downto 0);
           posX4 : out  STD_LOGIC_VECTOR (9 downto 0);
           posX5 : out  STD_LOGIC_VECTOR (9 downto 0);
           posX6 : out  STD_LOGIC_VECTOR (9 downto 0);
			  posX7 : out  STD_LOGIC_VECTOR (9 downto 0);
           posX8 : out  STD_LOGIC_VECTOR (9 downto 0));
end component;
component valsplit is
    Port ( valin : in  STD_LOGIC_VECTOR (31 downto 0);
           val1 : out  STD_LOGIC_VECTOR (3 downto 0);
           val2 : out  STD_LOGIC_VECTOR (3 downto 0);
           val3 : out  STD_LOGIC_VECTOR (3 downto 0);
           val4 : out  STD_LOGIC_VECTOR (3 downto 0);
           val5 : out  STD_LOGIC_VECTOR (3 downto 0);
           val6 : out  STD_LOGIC_VECTOR (3 downto 0);
           val7 : out  STD_LOGIC_VECTOR (3 downto 0);
           val8 : out  STD_LOGIC_VECTOR (3 downto 0));
end component;


--signals
--redOut
signal redOut1 : std_logic;
signal redOut2 : std_logic;
signal redOut3 : std_logic;
signal redOut4 : std_logic;
signal redOut5 : std_logic;
signal redOut6 : std_logic;
signal redOut7 : std_logic;
signal redOut8 : std_logic;
--greenOut
signal greenOut1 : std_logic;
signal greenOut2 : std_logic;
signal greenOut3 : std_logic;
signal greenOut4 : std_logic;
signal greenOut5 : std_logic;
signal greenOut6 : std_logic;
signal greenOut7 : std_logic;
signal greenOut8 : std_logic;
--blueOut
signal blueOut1 : std_logic;
signal blueOut2 : std_logic;
signal blueOut3 : std_logic;
signal blueOut4 : std_logic;
signal blueOut5 : std_logic;
signal blueOut6 : std_logic;
signal blueOut7 : std_logic;
signal blueOut8 : std_logic;
--posX
signal posX2Wire : STD_LOGIC_VECTOR (9 downto 0);
signal posX3Wire : STD_LOGIC_VECTOR (9 downto 0);
signal posX4Wire : STD_LOGIC_VECTOR (9 downto 0);
signal posX5Wire : STD_LOGIC_VECTOR (9 downto 0);
signal posX6Wire : STD_LOGIC_VECTOR (9 downto 0);
signal posX7Wire : STD_LOGIC_VECTOR (9 downto 0);
signal posX8Wire : STD_LOGIC_VECTOR (9 downto 0);
--val
signal val1Wire : STD_LOGIC_VECTOR (3 downto 0);
signal val2Wire : STD_LOGIC_VECTOR (3 downto 0);
signal val3Wire : STD_LOGIC_VECTOR (3 downto 0);
signal val4Wire : STD_LOGIC_VECTOR (3 downto 0);
signal val5Wire : STD_LOGIC_VECTOR (3 downto 0);
signal val6Wire : STD_LOGIC_VECTOR (3 downto 0);
signal val7Wire : STD_LOGIC_VECTOR (3 downto 0);
signal val8Wire : STD_LOGIC_VECTOR (3 downto 0);

begin
redOut <= redOut1 OR redOut2 OR redOut3 OR redOut4 OR redOut5 OR redOut6 OR redOut7 OR redOut8;
greenOut <= greenOut1 OR greenOut2 OR greenOut3 OR greenOut4 OR greenOut5 OR greenOut6 OR greenOut7 OR greenOut8;
blueOut <= blueOut1 OR blueOut2 OR blueOut3 OR blueOut4 OR blueOut5 OR blueOut6 OR blueOut7 OR blueOut8;
--entity
VSP1 : valsplit port map (--posXadd
									--in
									valin => val,
									--out
									val1 => val1Wire,
									val2 => val2Wire,
									val3 => val3Wire,
									val4 => val4Wire,
									val5 => val5Wire,
									val6 => val6Wire,
									val7 => val7Wire,
									val8 => val8Wire
									);
PXA1 : posXadd port map (--posXadd
									--in
									posXin => posX,
									--out
									posX2 => posX2Wire,
									posX3 => posX3Wire,
									posX4 => posX4Wire,
									posX5 => posX5Wire,
									posX6 => posX6Wire,
									posX7 => posX7Wire,
									posX8 => posX8Wire
									);
D1 : digit port map (--digit
									--in
									val => val1Wire,
									posX => posX,
									posY => posY,
									beamX => beamX,
									beamY => beamY,
									beamValid => beamValid,
									red => red,
									green => green,
									blue => blue,
									--out
									redOut => redOut1,
									greenOut => greenOut1,
									blueOut => blueOut1
									);
D2 : digit port map (--digit
									--in
									val => val2Wire,
									posX => posX2Wire,
									posY => posY,
									beamX => beamX,
									beamY => beamY,
									beamValid => beamValid,
									red => red,
									green => green,
									blue => blue,
									--out
									redOut => redOut2,
									greenOut => greenOut2,
									blueOut => blueOut2
									);
D3 : digit port map (--digit
									--in
									val => val3Wire,
									posX => posX3Wire,
									posY => posY,
									beamX => beamX,
									beamY => beamY,
									beamValid => beamValid,
									red => red,
									green => green,
									blue => blue,
									--out
									redOut => redOut3,
									greenOut => greenOut3,
									blueOut => blueOut3
									);
D4 : digit port map (--digit
									--in
									val => val4Wire,
									posX => posX4Wire,
									posY => posY,
									beamX => beamX,
									beamY => beamY,
									beamValid => beamValid,
									red => red,
									green => green,
									blue => blue,
									--out
									redOut => redOut4,
									greenOut => greenOut4,
									blueOut => blueOut4
									);
D5 : digit port map (--digit
									--in
									val => val5Wire,
									posX => posX5Wire,
									posY => posY,
									beamX => beamX,
									beamY => beamY,
									beamValid => beamValid,
									red => red,
									green => green,
									blue => blue,
									--out
									redOut => redOut5,
									greenOut => greenOut5,
									blueOut => blueOut5
									);
D6 : digit port map (--digit
									--in
									val => val6Wire,
									posX => posX6Wire,
									posY => posY,
									beamX => beamX,
									beamY => beamY,
									beamValid => beamValid,
									red => red,
									green => green,
									blue => blue,
									--out
									redOut => redOut6,
									greenOut => greenOut6,
									blueOut => blueOut6
									);
D7 : digit port map (--digit
									--in
									val => val7Wire,
									posX => posX7Wire,
									posY => posY,
									beamX => beamX,
									beamY => beamY,
									beamValid => beamValid,
									red => red,
									green => green,
									blue => blue,
									--out
									redOut => redOut7,
									greenOut => greenOut7,
									blueOut => blueOut7
									);
D8 : digit port map (--digit
									--in
									val => val8Wire,
									posX => posX8Wire,
									posY => posY,
									beamX => beamX,
									beamY => beamY,
									beamValid => beamValid,
									red => red,
									green => green,
									blue => blue,
									--out
									redOut => redOut8,
									greenOut => greenOut8,
									blueOut => blueOut8
									);


end Behavioral;

