
library ieee;
use ieee.std_logic_1164.all;

entity LCDdecoder is
port(
	datain: in  std_logic_vector (6 downto 0);
	dataout:out std_logic_vector (7 downto 0)
);
end;

architecture behave of LCDdecoder is
signal dis:std_logic_vector(7 downto 0);
begin
	process(datain)
		begin
		case datain is
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
	end process;
	
	dataout<=dis;

end behave;
