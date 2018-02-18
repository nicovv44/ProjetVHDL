----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:24:42 02/03/2018 
-- Design Name: 
-- Module Name:    testBench4 - Behavioral 
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

entity testBench is
end testBench;

architecture Behavioral of testBench is
component TOP is
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
end component;
-- input
signal clk502 : std_logic;
signal reset2 : std_logic;
--constants
constant clkPeriod : time := 2ns;
--architecture begin
begin
	TOP1 : TOP port map (clk50 => clk502,
							reset => reset2,
							posXP => '0',
							posXM => '0',
							posYP => '0',
							posYM => '0',
							freeMove => '0',
							zero => '0',
							subValSelect => '0'
							);
	clockprocess : process
	begin
		clk502 <= '0';
		wait for clkPeriod/2;
		clk502 <= '1';
		wait for clkPeriod/2;
	end process;
	resetprocess : process
	begin
		reset2 <= '0';
		wait for 100ns;
		reset2 <= '1';
		wait for 100ns;
		reset2 <= '0';
		wait;
	end process;


end Behavioral;
