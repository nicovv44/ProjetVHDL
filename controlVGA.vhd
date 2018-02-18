----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:26:56 01/27/2018 
-- Design Name: 
-- Module Name:    controlVGA - Behavioral 
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

entity controlVGA is
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
end controlVGA;

architecture rtl of controlVGA is

constant MAXCPTH: integer := 794;

--signal ckdiv2   : std_logic;
signal cpthmux  : std_logic_vector(9 downto 0);
signal cpth     : std_logic_vector(9 downto 0);
signal cptvmux  : std_logic_vector(9 downto 0);
signal cptv     : std_logic_vector(9 downto 0);

signal cpthsup95 : std_logic;
signal cpthsup138: std_logic;
signal cpthsup778: std_logic;
signal cpthsup794: std_logic;


signal cptvsup2 : std_logic;
signal cptvsup36 : std_logic;
signal cptvsup516 : std_logic;
signal cptvsup525: std_logic;

signal hblank : std_logic;
signal vblank : std_logic;

signal ckdiv2 : std_logic;

signal redComb, greenComb, blueComb : std_logic;

begin


redComb 		<= '0' when blank='0' else rIn;
greenComb 	<= '0' when blank='0' else gIn;
blueComb 	<= '0' when blank='0' else bIn;

rOut <= redComb when rising_edge(clk);
gOut <= greenComb when rising_edge(clk);
bOut <= blueComb when rising_edge(clk);

ckdiv2 <= '0' when reset='1'
           else not(ckdiv2) when rising_edge (clk);

cpthmux <= (others => '0') when cpthsup794='1'
           else std_logic_vector(unsigned(cpth)+1);

cpth <= (others => '0') when reset='1'
        else cpthmux when rising_edge(ckdiv2);

cpthsup95 <= '1' when unsigned(cpth)>=95 else '0';
cpthsup138 <= '1' when unsigned(cpth)>=138 else '0';
cpthsup778 <= '1' when unsigned(cpth)>=778 else '0';
cpthsup794 <= '1' when unsigned(cpth)>=794 else '0';

hsync <= cpthsup95;
hblank <= not(cpthsup138) or cpthsup778;

cptvmux <= (others => '0') when cptvsup525='1'
           else std_logic_vector(unsigned(cptv)+1) when cpthsup794='1'
           else cptv;

cptv <= (others => '0') when reset='1'
        else cptvmux when rising_edge(ckdiv2);

cptvsup2 <= '1' when unsigned (cptv)>=2 else '0';
cptvsup36 <= '1' when unsigned (cptv)>=36 else '0';
cptvsup516 <= '1' when unsigned (cptv)>=516 else '0';
cptvsup525 <= '1' when unsigned(cptv)>=525 else '0';

vsync <= cptvsup2;
vblank <= not(cptvsup36) or cptvsup516;

blank <= not (hblank or vblank);

beamValid <= blank when rising_edge (clk);


beamX <= std_logic_vector(unsigned(cpth)-138) when rising_edge (clk);
beamY <= std_logic_vector(unsigned(cptv)-36) when rising_edge (clk);


end rtl;

