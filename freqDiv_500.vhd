LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY freqDiv_500 IS
PORT(
	clk: IN STD_LOGIC;
	clk_out: OUT STD_LOGIC);
END freqDiv_500;

ARCHITECTURE behave OF freqDiv_500 IS
	SIGNAL tmp: INTEGER RANGE 0 TO 249;--count the clock
	SIGNAL clktmp: STD_LOGIC;--store the stage
	BEGIN
		PROCESS(clk)--asynchronous
		BEGIN
			IF (clk'event AND clk='1') THEN
				IF tmp=249 then
					tmp<=0;clktmp<=NOT clktmp;--frequency dividing
				else
					tmp<=tmp+1;--counting
				end if;
			end if;
		end process;
	clk_out<=clktmp;
end behave;