
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY keyINput IS
	PORT(
		clk:  IN  STD_LOGIC;
		clkt: IN  STD_LOGIC;
		btn0: IN  STD_LOGIC;
		btn1: IN  STD_LOGIC;
		btn2: IN  STD_LOGIC;
		btn3: IN  STD_LOGIC;
		btn4: IN  STD_LOGIC;
		btn5: IN  STD_LOGIC;
		btn6: IN  STD_LOGIC;
		bOUT0:OUT STD_LOGIC;
		bOUT1:OUT STD_LOGIC;
		bOUT2:OUT STD_LOGIC;
		bOUT3:OUT STD_LOGIC;
		bOUT4:OUT STD_LOGIC;
		bOUT5:OUT STD_LOGIC;
		bOUT6:OUT STD_LOGIC
		);
END keyINput;

ARCHITECTURE a OF keyINput IS
	SIGNAL resetmp1: STD_LOGIC;
	SIGNAL resetmp2: STD_LOGIC;
	SIGNAL resetmp3: STD_LOGIC;
	SIGNAL resetmp4: STD_LOGIC;
	SIGNAL resetmp5: STD_LOGIC;
	SIGNAL resetmp6: STD_LOGIC;
	SIGNAL resetmp7: STD_LOGIC;
	SIGNAL resetmp8: STD_LOGIC;
	SIGNAL resetmp9: STD_LOGIC;
	SIGNAL resetmp10:STD_LOGIC;
	SIGNAL resetmp11:STD_LOGIC;
	SIGNAL resetmp12:STD_LOGIC;
	SIGNAL resetmp13:STD_LOGIC;
	SIGNAL resetmp14:STD_LOGIC;
	begIN
	PROCESS(clk)
		begIN
		IF(clk'EVENT and clk='0') THEN
			resetmp1 <=btn0;
			resetmp2 <=resetmp1;
			resetmp3 <=btn1;
			resetmp4 <=resetmp3;
			resetmp6 <=resetmp5;
			resetmp5 <=btn2;
			resetmp8 <=resetmp7;
			resetmp7 <=btn3;
			resetmp10<=resetmp9;
			resetmp9 <=btn4;
			resetmp12<=resetmp11;
			resetmp11<=btn5;
			resetmp14<=resetmp13;
			resetmp13<=btn6;
		END IF;
	END PROCESS;
	
	bOUT0 <= resetmp1  and (not  resetmp2);
	bOUT1 <= resetmp3  and (not  resetmp4);
	bOUT2 <= resetmp5  and (not  resetmp6);
	bOUT3 <= resetmp7  and (not  resetmp8);
	bOUT4 <= resetmp9  and (not resetmp10);
	bOUT5 <= resetmp11 and (not resetmp12);
	bOUT6 <= resetmp13 and (not resetmp14);
END a;
	