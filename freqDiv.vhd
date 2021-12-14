LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY freqDiv IS
PORT(
	clk: IN STD_LOGIC;
	clk_out: OUT STD_LOGIC);
END freqDiv;

ARCHITECTURE behave OF freqDiv IS
	SIGNAL tmp: INTEGER RANGE 0 TO 24999;
	SIGNAL clktmp: STD_LOGIC;
	BEGIN
		PROCESS(clk)
		BEGIN
			IF (clk'event AND clk='1') THEN
				IF tmp=24999 then
					tmp<=0;clktmp<=NOT clktmp;
				else
					tmp<=tmp+1;
				end if;
			end if;
		end process;
	clk_out<=clktmp;
end behave;