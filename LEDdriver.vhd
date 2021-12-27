
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY LEDdriver is
  PORT(
     clk: IN  STD_LOGIC;
     sta: IN  STD_LOGIC_VECTOR (3 downto 0);
     led: OUT STD_LOGIC_VECTOR (15 downto 0)
  );
END LEDdriver;

ARCHITECTURE a of LEDdriver is
type all_state is(s0,s1,s2,s3,s4,s5,s6,s7,s8,s9,s10,s11,s12,s13,s14,s15);
SIGNAL cnt: STD_LOGIC :='0';
SIGNAL flag: STD_LOGIC:='0';
SIGNAL state:all_state;
begin
	PROCESS(clk)
	begin
		if(clk'event and clk = '1')then
		
			if(sta="0110" or sta="0111" or sta="1000") then
				flag <= '1';
			else flag <= '0'; end if;
		
			if(flag = '0') then
				led<="0000000000000000";
				state<=s0;
         end if;

         if(flag = '1')then
				case state is
            when s0=>state<=s1;
            led <= "0000000110000000";
            when s1=>state<=s2;
            led <= "0000001111000000";
            when s2=>state<=s3;
            led <= "0000011111100000";
            when s3=>state<=s4;
            led <= "0000111111110000";
            when s4=>state<=s5;
            led <= "0001111111111000";
            when s5=>state<=s6;
            led <= "0011111111111100";
            when s6=>state<=s7;
            led <= "0111111111111110";
            when s7=>state<=s8;
            led <= "1111111111111111";
            when s8=>state<=s9;
            led <= "0111111111111110";
            when s9=>state<=s10;
            led <= "0011111111111100";
            when s10=>state<=s11;
            led <= "0001111111111000";
            when s11=>state<=s12;
            led <= "0000111111110000";
            when s12=>state<=s13;
            led <= "0000011111100000";
            when s13=>state<=s14;
            led <= "0000001111000000";
            when s14=>state<=s15;
            led <= "0000000110000000";
            when s15=>state<=s0;
            led <= "0000000000000000";
         end case;
     end if;
  end if;
  end PROCESS;
END a;
