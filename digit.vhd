----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    13:32:34 01/27/2018 
-- Design Name: 
-- Module Name:    digit - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity digit is
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
end digit;

architecture Behavioral of digit is

Type DigitRom is array (0 to 7) of std_logic_vector (0 to 7);

signal Rom_0 : DigitRom;
signal Rom_1 : DigitRom;
signal Rom_2 : DigitRom;
signal Rom_3 : DigitRom;
signal Rom_4 : DigitRom;
signal Rom_5 : DigitRom;
signal Rom_6 : DigitRom;		
signal Rom_7 : DigitRom;		
signal Rom_8 : DigitRom;		
signal Rom_9 : DigitRom;		
signal Rom_A : DigitRom;		
signal Rom_B : DigitRom;		
signal Rom_C : DigitRom;		
signal Rom_D : DigitRom;		
signal Rom_E : DigitRom;
signal Rom_F : DigitRom;

signal newPosX : std_logic_vector(10 downto 0);
signal newPosY : std_logic_vector(10 downto 0);
signal sigValid, romSig : std_logic;

begin
Rom_0 <= (	"01110000", 
				"10001000", 
				"10011000", 
				"10101000", 
				"11001000", 
				"10001000", 
				"01110000",
				"00000000");

Rom_1 <= (	"00100000", 
				"01100000", 
				"00100000", 
				"00100000", 
				"00100000", 
				"00100000", 
				"01110000",
				"00000000");

Rom_2 <= (	"01110000", 
				"10001000", 
				"00001000", 
				"00010000", 
				"00100000", 
				"01000000", 
				"11111000",
				"00000000");

Rom_3 <= (	"11111000", 
				"00010000", 
				"00100000", 
				"00010000", 
				"00001000", 
				"10001000", 
				"01110000",
				"00000000");

Rom_4 <= (	"00010000", 
				"00110000", 
				"01010000", 
				"10010000", 
				"11111000", 
				"00010000", 
				"00010000",
				"00000000");

Rom_5 <= (	"11111000", 
				"10000000", 
				"11110000", 
				"00001000", 
				"00001000", 
				"10001000", 
				"01110000",
				"00000000");

Rom_6 <= (	"00110000", 
				"01000000", 
				"10000000", 
				"11110000", 
				"10001000", 
				"10001000", 
				"01110000",
				"00000000");

Rom_7 <= (	"11111000", 
				"00001000", 
				"00010000", 
				"00100000", 
				"00100000", 
				"00100000", 
				"00100000",
				"00000000");

Rom_8 <= (	"01110000", 
				"10001000", 
				"10001000", 
				"01110000", 
				"10001000", 
				"10001000", 
				"01110000",
				"00000000");

Rom_9 <= (	"01110000", 
				"10001000", 
				"10001000", 
				"01111000", 
				"00001000", 
				"00010000", 
				"01100000",
				"00000000");

Rom_A <= (	"01110000", 
				"10001000", 
				"10001000", 
				"11111000", 
				"10001000", 
				"10001000", 
				"10001000", 
				"00000000");

Rom_B <= (	"11110000", 
				"10001000", 
				"10001000", 
				"11110000", 
				"10001000", 
				"10001000", 
				"11110000", 
				"00000000");

Rom_C <= (	"01110000", 
				"10001000", 
				"10000000", 
				"10000000", 
				"10000000", 
				"10001000", 
				"01110000",
				"00000000");

Rom_D <= (	"11100000", 
				"10010000", 
				"10001000", 
				"10001000", 
				"10001000", 
				"10010000", 
				"11100000",
				"00000000");

Rom_E <= (	"11111000", 
				"10000000", 
				"10000000", 
				"11110000", 
				"10000000", 
				"10000000", 
				"11111000",
				"00000000");

Rom_F <= (	"11111000", 
				"10000000", 
				"10000000", 
				"11110000", 
				"10000000", 
				"10000000", 
				"10000000", 
				"00000000");

newPosX <= std_logic_vector(('0'&unsigned(beamX))-('0'&unsigned(posX)));
newPosY <= std_logic_vector(('0'&unsigned(beamY))-('0'&unsigned(posY)));
sigValid <= '1' when signed(newPosX)<5 and signed(newPosX)>=0 and signed(newPosY)>=0 and signed(newPosY)<7 and beamValid='1' else '0';
romSig <= '1' when (Rom_0(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="0000") or 
						 (Rom_1(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="0001") or 
 						 (Rom_2(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="0010") or 
 						 (Rom_3(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="0011") or 
 						 (Rom_4(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="0100") or 
 						 (Rom_5(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="0101") or 
 						 (Rom_6(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="0110") or 
 						 (Rom_7(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="0111") or 
 						 (Rom_8(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="1000") or 
 						 (Rom_9(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="1001") or 
 						 (Rom_A(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="1010") or 
 						 (Rom_B(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="1011") or 
 						 (Rom_C(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="1100") or 
 						 (Rom_D(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="1101") or 
 						 (Rom_E(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="1110") or 
 						 (Rom_F(to_integer(unsigned(newPosY(2 downto 0))))(to_integer(unsigned(newPosX(2 downto 0))))='1' and sigValid='1' and val="1111") 
			else '0';

redOut <= 	'1' when red='1' and romSig='1' 
				else '0';

greenOut <= 	'1' when green='1' and romSig='1'
				else '0';

blueOut <= 	'1' when blue='1' and romSig='1'
				else '0';


end Behavioral;

