LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY latticeDriver is

PORT(
	clk :IN STD_LOGIC;								            -- origINal clock @ 1kHz
	clk_div1000 : IN  STD_LOGIC;							      -- divided  clock @ 1Hz
	clk_div500 :  IN  STD_LOGIC;							      -- divided  clock @ 2Hz
	clk_div250 :  IN  STD_LOGIC;							      -- divided  clock @ 4Hz
	clk_div125 :  IN  STD_LOGIC;							      -- divided  clock @ 8Hz
	state_in :    IN  STD_LOGIC_VECTOR (3 downto 0);	   -- now status
	col_r :       OUT STD_LOGIC_VECTOR (7 downto 0);   	-- R LED control
	col_g :       OUT STD_LOGIC_VECTOR (7 downto 0);   	-- G LED control
	row :         OUT STD_LOGIC_VECTOR (7 downto 0) 		-- LED neg PORT control
);

end latticeDriver;

ARCHITECTURE a of latticeDriver is

SIGNAL sel2 :   STD_LOGIC_VECTOR(0 downto 0); 	         -- SIGNAL::counter   % 2
SIGNAL sel2_2 : STD_LOGIC_VECTOR(0 downto 0);            -- SIGNAL::counter_2 % 2
SIGNAL sel2_4 : STD_LOGIC_VECTOR(0 downto 0); 	         -- SIGNAL::counter_4 % 2
SIGNAL sel2_8 : STD_LOGIC_VECTOR(0 downto 0);            -- SIGNAL::counter_8 % 2
SIGNAL sel8 :   STD_LOGIC_VECTOR(2 downto 0); 	         -- SIGNAL::counter   % 8

begin

p1:PROCESS(clk)										            -- counter (%8)
begin
	if (clk'event and clk='1') then 
		sel8 <= sel8 + 1;
	end if;
end PROCESS p1;

p2:PROCESS(clk_div1000)                                  -- counter (%2, @1Hz, OUT 0.5Hz)
begin
	if (clk_div1000'event and clk_div1000='1')then 
		sel2 <= sel2 + 1;
	end if; 
end PROCESS p2;

p3:PROCESS(clk_div500)								            -- counter_2 (%2, @2Hz, OUT 1Hz)
begin
	if (clk_div500'event and clk_div500='1')then 
		sel2_2 <= sel2_2 + 1;
	end if; 
end PROCESS p3;

p4:PROCESS(clk_div250)								            -- counter_4 (%2, @4Hz, OUT 2Hz)
begin
	if (clk_div250'event and clk_div250='1')then 
		sel2_4 <= sel2_4 + 1;
	end if; 
end PROCESS p4;

p5:PROCESS(clk_div125)								            -- counter_8 (%2, @8Hz, OUT 4Hz)
begin
	if (clk_div125'event and clk_div125='1')then 
		sel2_8 <= sel2_8 + 1;
	end if; 
end PROCESS p5;

p6:PROCESS(state_in,sel2,sel8)

-- %8: reflush row
-- %7: select  pos

-- state machINe status description:
-- standard group:
-- 0010 :  2 : set first  time for R box
-- 0011 :  3 : set first  time for B box
-- 0100 :  4 : set first  time for Y box
-- 1010 : 10 : set second time for R box
-- 1011 : 11 : set second time for B box
-- 1100 : 12 : set second time for Y box
-- 0101 :  5 : count down start
-- 0110 :  6 : R box alert triggered
-- 0111 :  7 : G box alert triggered
-- 1000 :  8 : Y box alert triggered
-- specialized group:
-- 0000 :  0 : power off
-- 0001 :  1 : power on
-- 1111 : 31 : set finish

begin
if (state_in="0000") then
-- turn off all INdicators
-- state 0000 : 0 : power off
case sel8 is
	when O"7" => col_r <= "00000000"; col_g <= "00000000"; row<= "01111111";
	when O"6" => col_r <= "00000000"; col_g <= "00000000"; row<= "10111111"; 
	when O"5" => col_r <= "00000000"; col_g <= "00000000"; row<= "11011111"; 
	when O"4" => col_r <= "00000000"; col_g <= "00000000"; row<= "11101111"; 
	when O"3" => col_r <= "00000000"; col_g <= "00000000"; row<= "11110111"; 
	when O"2" => col_r <= "00000000"; col_g <= "00000000"; row<= "11111011"; 
	when O"1" => col_r <= "00000000"; col_g <= "00000000"; row<= "11111101"; 
	when O"0" => col_r <= "00000000"; col_g <= "00000000"; row<= "11111110"; 
end case;

elsif (state_in="0001" OR state_in="0101" OR state_in="1111") then
-- three INdicators always on
-- state 0001 :  1 : power on, 3 INdicators always on
-- state 0101 :  5 : count down start
-- state 1111 : 31 : set finish
case sel8 is
	when O"7" => col_r <= "00000000"; col_g <= "00000000"; row <= "01111111";
	when O"6" => col_r <= "00000000"; col_g <= "00000000"; row <= "10111111"; 
	when O"5" => col_r <= "00000000"; col_g <= "00000000"; row <= "11011111"; 
	when O"4" => col_r <= "11000011"; col_g <= "11011000"; row <= "11101111"; 
	when O"3" => col_r <= "11000011"; col_g <= "11011000"; row <= "11110111"; 
	when O"2" => col_r <= "00000000"; col_g <= "00000000"; row <= "11111011"; 
	when O"1" => col_r <= "00000000"; col_g <= "00000000"; row <= "11111101"; 
	when O"0" => col_r <= "00000000"; col_g <= "00000000"; row <= "11111110"; 
end case;

elsif (state_in="0010" or state_in="1010") then
-- INdicator r blINk @ 
	case sel2_2 is
		when "0" => case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="11000011";col_g<="11011000";row<="11101111"; 
			when O"3" =>col_r<="11000011";col_g<="11011000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110";
						end case;
		when "1" => case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="11000000";col_g<="11011000";row<="11101111"; 
			when O"3" =>col_r<="11000000";col_g<="11011000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110"; 
						end case;
		end case;
elsif (state_in="0011" or state_in="1011") then
	case sel2_2 is
		when "0"=> case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="11000011";col_g<="11011000";row<="11101111"; 
			when O"3" =>col_r<="11000011";col_g<="11011000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110"; 
						end case;
		when "1"=> case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="11000011";col_g<="11000000";row<="11101111"; 
			when O"3" =>col_r<="11000011";col_g<="11000000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110";  
						end case;
		end case;
elsif (state_in="0100" or state_in="1100") then
	case sel2_2 is
		when "0"=> case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="11000011";col_g<="11011000";row<="11101111"; 
			when O"3" =>col_r<="11000011";col_g<="11011000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110"; 
						end case;
		when "1"=> case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="00000011";col_g<="00011000";row<="11101111"; 
			when O"3" =>col_r<="00000011";col_g<="00011000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110"; 
						end case;
		end case;
elsif (state_in="0110") then
	case sel2_8 is
		when "0"=> case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="11000011";col_g<="11011000";row<="11101111"; 
			when O"3" =>col_r<="11000011";col_g<="11011000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110";
						end case;
		when "1"=> case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="11000000";col_g<="11011000";row<="11101111"; 
			when O"3" =>col_r<="11000000";col_g<="11011000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110"; 
						end case;
		end case;

elsif (state_in="0111") then
	case sel2_8 is
		when "0"=> case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="11000011";col_g<="11011000";row<="11101111"; 
			when O"3" =>col_r<="11000011";col_g<="11011000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110"; 
						end case;
		when "1"=> case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="11000011";col_g<="11000000";row<="11101111"; 
			when O"3" =>col_r<="11000011";col_g<="11000000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110";  
						end case;
		end case;
elsif (state_in="1000") then
	case sel2_8 is
		when "0"=> case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="11000011";col_g<="11011000";row<="11101111"; 
			when O"3" =>col_r<="11000011";col_g<="11011000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110"; 
						end case;
		when "1"=> case sel8 is
			when O"7" =>col_r<="00000000";col_g<="00000000";row<="01111111";
			when O"6" =>col_r<="00000000";col_g<="00000000";row<="10111111"; 
			when O"5" =>col_r<="00000000";col_g<="00000000";row<="11011111"; 
			when O"4" =>col_r<="00000011";col_g<="00011000";row<="11101111"; 
			when O"3" =>col_r<="00000011";col_g<="00011000";row<="11110111"; 
			when O"2" =>col_r<="00000000";col_g<="00000000";row<="11111011"; 
			when O"1" =>col_r<="00000000";col_g<="00000000";row<="11111101"; 
			when O"0" =>col_r<="00000000";col_g<="00000000";row<="11111110"; 
						end case;
		end case;
end if;
end PROCESS p6; 

end a;
