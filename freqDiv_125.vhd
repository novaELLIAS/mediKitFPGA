LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY freqDiv_125 IS
PORT(
	clk: IN STD_LOGIC;
	clk_out: OUT STD_LOGIC);
END freqDiv_125;

ARCHITECTURE behave OF freqDiv_125 IS
	SIGNAL tmp: INTEGER RANGE 0 TO 62;
	SIGNAL clktmp: STD_LOGIC;
	begin
		PROCESS(clk)
		begin
			IF (clk'event AND clk='1') THEN
				IF tmp=62 then
					tmp<=0;clktmp<=NOT clktmp;
				else
					tmp<=tmp+1;
				end if;
			end if;
		end PROCESS;
	clk_out<=clktmp;
end behave;