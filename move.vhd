----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:19:46 02/16/2018 
-- Design Name: 
-- Module Name:    move4 - Behavioral 
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

entity move is
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
end move;

architecture Behavioral of move is

--components
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
signal posXP2 : STD_LOGIC;
signal posXM2 : STD_LOGIC;
signal posYP2 : STD_LOGIC;
signal posYM2 : STD_LOGIC;

begin

posXP2 <= '1' when freeMove = '1'
	else posXP;
posXM2 <= '1' when freeMove = '1'
	else posXM;
posYP2 <= '1' when freeMove = '1'
	else posYP;
posYM2 <= '1' when freeMove = '1'
	else posYM;

--instances
	MOVX : mover port map(
								--in
								clk => clk,
								reset => reset,
								posReset => std_logic_vector(to_unsigned(150, 10)),--on 10 bits
								posMin =>   std_logic_vector(to_unsigned(0,   10)),--on 10 bits
								posMax =>   std_logic_vector(to_unsigned(569, 10)),--on 10 bits
								posP => posXP2,
								posM => posXM2,
								subValSelect => subValSelect,
								--inout
								pos => posX
								);
	MOVY : mover port map(
								--in
								clk => clk,
								reset => reset,
								posReset => std_logic_vector(to_unsigned(150, 10)),--on 10 bits
								posMin =>   std_logic_vector(to_unsigned(0,   10)),--on 10 bits
								posMax =>   std_logic_vector(to_unsigned(475, 10)),--on 10 bits
								posP => posYP2,
								posM => posYM2,
								subValSelect => subValSelect,
								--inout
								pos => posY
								);

end Behavioral;

