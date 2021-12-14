library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity LCD1602driver is
	Port(
		LCD_Clk :   in std_logic;  
		LCD_RS :    out std_logic; -- switch
		LCD_RW :    out std_logic; -- LCD R/W
		LCD_EN :    out std_logic; -- enable
		lcd_data :  out std_logic_vector(7 downto 0);
		YIMA_DATA1: in std_logic_vector(7 downto 0);
		YIMA_DATA2: in std_logic_vector(7 downto 0);
		YIMA_DATA3: in std_logic_vector(7 downto 0);
		YIMA_DATA4: in std_logic_vector(7 downto 0);
		YIMA_DATA5: in std_logic_vector(7 downto 0);
		YIMA_DATA6: in std_logic_vector(7 downto 0);
		YIMA_DATA7: in std_logic_vector(7 downto 0);
		YIMA_DATA8: in std_logic_vector(7 downto 0);
		YIMA_DATA9: in std_logic_vector(7 downto 0);
		YIMA_DATA10:in std_logic_vector(7 downto 0);
		YIMA_DATA11:in std_logic_vector(7 downto 0);
		YIMA_DATA12:in std_logic_vector(7 downto 0)
);
end LCD1602driver;
architecture a of LCD1602driver is
  
type ram is array(0 to 28) of std_logic_vector(7 downto 0);
signal ram1:ram;

begin
	LCD_EN <= LCD_Clk ;
	LCD_RW <= '0' ;
	
	ram1(0) <=YIMA_DATA1;
	ram1(1) <=YIMA_DATA2;
	ram1(2) <=YIMA_DATA3;
	ram1(3) <=YIMA_DATA4;
	ram1(4) <=YIMA_DATA5;
	ram1(5) <=YIMA_DATA6;
	ram1(6) <=YIMA_DATA7;
	ram1(7) <=YIMA_DATA8;
	ram1(8) <=YIMA_DATA9;
	ram1(9) <=YIMA_DATA10;
	ram1(10)<=YIMA_DATA11;
	ram1(11)<=YIMA_DATA12;
	
process(LCD_Clk)
variable cnt :integer range 0 to 38;
begin

if LCD_Clk'event and LCD_Clk = '1'then
	if cnt =38 then cnt :=0;
	else cnt :=cnt +1;
	end if;
end if;
  
case cnt is
-- INIT
when 0 =>LCD_RS<='0';lcd_data<="00111000";  --0x38,
when 1 =>LCD_RS<='0';lcd_data<="00001100";  --0x0C
when 2 =>LCD_RS<='0';lcd_data<="00000001";  --0x01
when 3 =>LCD_RS<='0';lcd_data<="00000110";  --0x06
when 4 =>LCD_RS<='0';lcd_data<="10000000";  --0x80
-- display,0x00+0x80

-- display
when 5 =>LCD_RS<='1';lcd_data<="10100000";
when 6 =>LCD_RS<='1';lcd_data<="10100000";
when 7 =>LCD_RS<='1';lcd_data<="01000001";
when 8 =>LCD_RS<='1';lcd_data<="00111110";
when 9 =>LCD_RS<='1';lcd_data<=ram1(0);
when 10=>LCD_RS<='1';lcd_data<=ram1(1);
when 11=>LCD_RS<='1';lcd_data<="10100000";
when 12=>LCD_RS<='1';lcd_data<="01000010";
when 13=>LCD_RS<='1';lcd_data<="00111110";
when 14=>LCD_RS<='1';lcd_data<=ram1(4);
when 15=>LCD_RS<='1';lcd_data<=ram1(5);
when 16=>LCD_RS<='1';lcd_data<="10100000";
when 17=>LCD_RS<='1';lcd_data<="01000011";
when 18=>LCD_RS<='1';lcd_data<="00111110";
when 19=>LCD_RS<='1';lcd_data<=ram1(8);
when 20=>LCD_RS<='1';lcd_data<=ram1(9);
when 21=>LCD_RS<='0';lcd_data<="11000000";
when 22=>LCD_RS<='1';lcd_data<="10100000";
when 23=>LCD_RS<='1';lcd_data<="10100000";
when 24=>LCD_RS<='1';lcd_data<="10100000";
when 25=>LCD_RS<='1';lcd_data<="10100000";
when 26=>LCD_RS<='1';lcd_data<=ram1(2);
when 27=>LCD_RS<='1';lcd_data<=ram1(3);
when 28=>LCD_RS<='1';lcd_data<="10100000";
when 29=>LCD_RS<='1';lcd_data<="10100000";
when 30=>LCD_RS<='1';lcd_data<="10100000";
when 31=>LCD_RS<='1';lcd_data<=ram1(6);
when 32=>LCD_RS<='1';lcd_data<=ram1(7);
when 33=>LCD_RS<='1';lcd_data<="10100000"; 
when 34=>LCD_RS<='1';lcd_data<="10100000";
when 35=>LCD_RS<='1';lcd_data<="10100000";
when 36=>LCD_RS<='1';lcd_data<=ram1(10);
when 37=>LCD_RS<='1';lcd_data<=ram1(11); 
when 38=>LCD_RS<='1';lcd_data<="10100000";
end case;	  
             
end process;
end a;
