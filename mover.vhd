----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:57:08 02/14/2018 
-- Design Name: 
-- Module Name:    move3 - Behavioral 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;--so + is understoud
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mover is
    Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  posReset : in  STD_LOGIC_VECTOR (9 downto 0);
			  posMin : in  STD_LOGIC_VECTOR (9 downto 0);
			  posMax : in  STD_LOGIC_VECTOR (9 downto 0);
			  posP : in  STD_LOGIC;
			  posM : in  STD_LOGIC;
			  subValSelect : in  STD_LOGIC;
           pos : inout  STD_LOGIC_VECTOR (9 downto 0));
end mover;

architecture Behavioral of mover is

--components
component clkSub is
	Port ( clk : in  STD_LOGIC;
           reset : in  STD_LOGIC;
			  subVal : in  STD_LOGIC_VECTOR (25 downto 0);
           clks : inout  STD_LOGIC);
end component;

--signals
signal posmux : STD_LOGIC_VECTOR (9 downto 0);
signal sens : std_logic;
signal sensMux : std_logic;
signal max : std_logic;
signal min : std_logic;
signal pressed : std_logic;
signal refreshNextPosition : std_logic;
signal subVal : STD_LOGIC_VECTOR (25 downto 0);

begin
pos <= posReset when reset='1'
        else posmux when rising_edge(clk);

sens <= '1' when reset='1'
        else sensMux when rising_edge(clk);

posmux <= std_logic_vector(unsigned(pos)+1)   when (pressed='1' and sens='1' and refreshNextPosition='1')
	else std_logic_vector(unsigned(pos)-1) when (pressed='1' and sens='0' and refreshNextPosition='1')
	else pos;

sensMux <= '1'   when (max='0' and min='1')
	else '0' when (max='1' and min='0')
	else '1' when (posM='0' and posP='1' and max='0' and min='0')
	else '0' when (posM='1' and posP='0' and max='0' and min='0')
	else sens;
	
max <= '1' when pos = posMax else '0';
min <= '1' when pos = posMin else '0';

--clockPressed
pressed <= posP or posM;

--subVal slection
subVal <= "00000000001100001101010000" when subValSelect='0'-- 50,000 on 26 bits
	else "00000001111010000100100000"; --500,000

--instances
	CLKS1 : clkSub port map(
								--in
								clk => clk,
								reset => reset,
								subVal => subVal,-- on 26 bits
								--inout
								clks => refreshNextPosition
								);

end Behavioral;

