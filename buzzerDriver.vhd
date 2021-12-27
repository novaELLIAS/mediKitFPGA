LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
ENTITY buzzerDriver is
	PORT(
		clk_base:IN  STD_LOGIC;
		clk_ctr: IN  STD_LOGIC;
		state_in:IN  STD_LOGIC_VECTOR(3 downto 0);
		buzz_OUT:OUT STD_LOGIC:='0'
);
end buzzerDriver;

ARCHITECTURE behave of buzzerDriver is
SIGNAL count:INTEGER range 0 to 1;
SIGNAL buz0: STD_LOGIC:='0';
begin
p1:PROCESS(clk_ctr) -- 2f switch
begin
	if(clk_ctr'event and clk_ctr='1')then
		if(count=1)then
			count<=0;
		else count<=count+1;
		end if;
	end if;
end PROCESS p1;

p2:PROCESS(clk_base) -- f division
variable c1:INTEGER range 0 to 1:=0;
begin
	if(clk_base'event and clk_base='1')then
		if c1=1 then
			buz0<=not buz0;c1:=0;
		else c1:=c1+1;
		end if;
	end if;
end PROCESS p2;

p3:PROCESS(state_in)
begin
	if(state_in="0110" or state_in="0111" or state_in="1000")then
		case count is
			when 0=>buzz_OUT<=clk_base;
			when 1=>buzz_OUT<=buz0;
			when others=>null;
		end case;
	else buzz_OUT<='0';
	end if;
end PROCESS p3;

end behave;