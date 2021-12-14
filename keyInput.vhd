
library IEEE;
use IEEE.std_logic_1164.all;
entity keyInput is
	port(
		clk:  in  std_logic;
		clkt: in  std_logic;
		btn0: in  std_logic;
		btn1: in  std_logic;
		btn2: in  std_logic;
		btn3: in  std_logic;
		btn4: in  std_logic;
		btn5: in  std_logic;
		btn6: in  std_logic;
		bout0:out std_logic;
		bout1:out std_logic;
		bout2:out std_logic;
		bout3:out std_logic;
		bout4:out std_logic;
		bout5:out std_logic;
		bout6:out std_logic
		);
end keyInput;

architecture a of keyInput is
	signal resetmp1: std_logic;
	signal resetmp2: std_logic;
	signal resetmp3: std_logic;
	signal resetmp4: std_logic;
	signal resetmp5: std_logic;
	signal resetmp6: std_logic;
	signal resetmp7: std_logic;
	signal resetmp8: std_logic;
	signal resetmp9: std_logic;
	signal resetmp10:std_logic;
	signal resetmp11:std_logic;
	signal resetmp12:std_logic;
	signal resetmp13:std_logic;
	signal resetmp14:std_logic;
	begin
	process(clk)
		begin
		if(clk'event and clk='0')then
			resetmp2 <=resetmp1;
			
			resetmp4 <=resetmp3;
			
			resetmp6 <=resetmp5;
			
			resetmp8 <=resetmp7;
			
			resetmp10<=resetmp9;
			
			resetmp12<=resetmp11;
			
			resetmp14<=resetmp13;
			
		end if;
	end process;
	PROCESS (clkt) begin
		if (clkt'event and clkt='0')then
			resetmp1 <=btn0;
			resetmp3 <=btn1;
			resetmp5 <=btn2;
			resetmp7 <=btn3;
			resetmp9 <=btn4;
			resetmp11<=btn5;
			resetmp13<=btn6;
		end if;
	END PROCESS;
	bout0 <= clk and resetmp1  and (not  resetmp2);
	bout1 <= clk and resetmp3  and (not  resetmp4);
	bout2 <= clk and resetmp5  and (not  resetmp6);
	bout3 <= clk and resetmp7  and (not  resetmp8);
	bout4 <= clk and resetmp9  and (not resetmp10);
	bout5 <= clk and resetmp11 and (not resetmp12);
	bout6 <= clk and resetmp13 and (not resetmp14);
end a;
	