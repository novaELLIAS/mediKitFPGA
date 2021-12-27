
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY LCDdecoder is
PORT(
	dataIN: IN  STD_LOGIC_VECTOR (6 downto 0);
	dataOUT:OUT STD_LOGIC_VECTOR (7 downto 0)
);
end;

ARCHITECTURE behave of LCDdecoder is
SIGNAL dis:STD_LOGIC_VECTOR(7 downto 0);
begin
	PROCESS(dataIN)
		begin
		case dataIN is
			when "1111110"=>dis<="00110000"; -- '0'
			when "0110000"=>dis<="00110001"; -- '1'
			when "1101101"=>dis<="00110010"; -- '2'
			when "1111001"=>dis<="00110011"; -- '3'
			when "0110011"=>dis<="00110100"; -- '4'
			when "1011011"=>dis<="00110101"; -- '5'
			when "1011111"=>dis<="00110110"; -- '6'
			when "1110000"=>dis<="00110111"; -- '7'
			when "1111111"=>dis<="00111000"; -- '8'
			when "1111011"=>dis<="00111001"; -- '9'
			when others=>dis<="00100000";    -- " "
		end case;
	end PROCESS;
	
	dataOUT<=dis;

end behave;
