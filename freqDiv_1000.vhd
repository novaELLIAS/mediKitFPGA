
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY freqDiv_1000 IS
PORT(
	clk: IN STD_LOGIC;
	clk_OUT: OUT STD_LOGIC);
END freqDiv_1000;

ARCHITECTURE behave OF freqDiv_1000 IS
	SIGNAL tmp: INTEGER RANGE 0 TO 499;
	SIGNAL clktmp: STD_LOGIC;
	begin
		PROCESS(clk)
		begin
			IF (clk'event AND clk='1') THEN
				IF tmp=499 then
					tmp<=0;clktmp<=NOT clktmp;
				else
					tmp<=tmp+1;
				end if;
			end if;
		end PROCESS;
	clk_OUT<=clktmp;
end behave;