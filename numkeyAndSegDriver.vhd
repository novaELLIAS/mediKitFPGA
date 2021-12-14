library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity numKeyAndSegDriver is
port(
	clkin:   in  std_logic;
	clk_div: in  std_logic;
	--cnt_un:  in  integer range 0 to 1000000:=0; -- cnt unntaken
	cnt_u1:  in integer range 0 to 31:=0;       -- cnt unntaken 1
	cnt_u2:  in integer range 0 to 31:=0;       -- cnt unntaken 2
	cnt_u3:  in integer range 0 to 31:=0;       -- cnt unntaken 3
	key_r:   in  std_logic_vector(3 downto 0);  -- 4x4 input
	key_c:   out std_logic_vector(3 downto 0);  -- 4x4 output
	state_in:in  std_logic_vector(3 downto 0);  -- untaken counter
	seg:     out std_logic_vector(6 downto 0);  -- nixie output
	cat:     out std_logic_vector(7 downto 0);  -- nixie cat
	nums:    out std_logic_vector(6 downto 0);  -- _x return
	numb:    out std_logic_vector(6 downto 0)   -- x_ return
);
end numKeyAndSegDriver;

architecture a of numKeyAndSegDriver is
	signal key_c0:std_logic_vector(3 downto 0);
	signal C:integer range 0 to 16:=0;
	signal pre:integer range 0 to 16:=0;
	signal flag:integer range 0 to 1:=0;
	signal nums_temp: std_logic_vector(6 downto 0):="1111110";
	signal numb_temp: std_logic_vector(6 downto 0):="1111110";
	signal seg_temp1: std_logic_vector(6 downto 0):="1111110";
	signal seg_temp2: std_logic_vector(6 downto 0):="1111110";
	signal seg_temp3: std_logic_vector(6 downto 0):="1111110";
	signal seg_temp4: std_logic_vector(6 downto 0):="1111110";
	signal seg_temp5: std_logic_vector(6 downto 0):="1111110";
	signal seg_temp6: std_logic_vector(6 downto 0):="1111110";
	signal seg_temp7: std_logic_vector(6 downto 0):="1111111";
	signal seg_temp8: std_logic_vector(6 downto 0):="1111111";
	signal seg_temp9: std_logic_vector(6 downto 0):="1111110";
	signal seg_temp10:std_logic_vector(6 downto 0):="1111110";
	signal seg_temp11:std_logic_vector(6 downto 0):="1111110";
	signal seg_temp12:std_logic_vector(6 downto 0):="1111110";
	signal seg_temp13:std_logic_vector(6 downto 0):="1111110";
	signal seg_temp14:std_logic_vector(6 downto 0):="1111110";
	signal seg_tempna:std_logic_vector(6 downto 0):="1111110";
	signal seg_tempnb:std_logic_vector(6 downto 0):="1111110";
--	signal seg_temp1a:std_logic_vector(6 downto 0):="1111110";
--	signal seg_temp1b:std_logic_vector(6 downto 0):="1111110";
--	signal seg_temp2a:std_logic_vector(6 downto 0):="1111110";
--	signal seg_temp2b:std_logic_vector(6 downto 0):="1111110";
--	signal seg_temp3a:std_logic_vector(6 downto 0):="1111110";
--	signal seg_temp3b:std_logic_vector(6 downto 0):="1111110";
	signal sel61 :integer range 0 to 60:=0;    -- counter %61
	signal count_btn3:integer range 0 to 1:=0; -- 1r, 2g, 3y
begin  
    
P0:process(clkin)
variable sel4:integer range 0 to 3:=0; -- keyboard row scan
begin
	if clkin'event and clkin='1' then
		case sel4 is
			when 0=> key_c0 <="1110";
			when 1=> key_c0 <="1101";
			when 2=> key_c0 <="1011";
			when 3=> key_c0 <="0111";
			when others=>null;
		end case;
		
		if sel4=3 then sel4:=0;
		else sel4:=sel4+1;
		end if;
	end if;
end process P0;
	
key_c <= key_c0;
   
P1:process(key_c0,key_r, clkin) -- keyboard line readin
begin
	if (clkin'event AND clkin='1') then
		if(state_in="0000")then C<=0;
		else
		case key_c0 is
			when"1110"=>
				case key_r is
					when"0111"=> C<=1;
					when"1011"=> C<=5;
					when"1101"=> C<=9;
					when"1110"=> C<=13;
					when others=>C<=C;
				end case;
			when"1101"=>
				case key_r is
						when"0111"=> C<=2;
						when"1011"=> C<=6;
						when"1101"=> C<=10;
						when"1110"=> C<=14;
						when others=>C<=C;
				end case;
			when"1011"=>
				case key_r is
               when"0111"=> C<=3;
               when"1011"=> C<=7;
               when"1101"=> C<=11;
               when"1110"=> C<=15;
               when others=>C<=C;
				end case;
			when"0111"=>
				case key_r is
               when"0111"=> C<=4;
               when"1011"=> C<=8;
               when"1101"=> C<=12;
               when"1110"=> C<=16;
               when others=>C<=C;
           end case;
         when others=>C<=C;
         end case;
		end if;
	end if;
end process P1;
    
process(clkin)
begin
if(clkin'event and clkin='1') then -- if sta@timesetting -> return num to control
    if(state_in="0010" or state_in="0011" or state_in="0100" or state_in="1010" or state_in="1011" or state_in="1100") then
		case C is
           when 1 => nums_temp<="1111110"; --0
           when 2 => nums_temp<="0110000"; --1
           when 3 => nums_temp<="1101101"; --2
           when 4 => nums_temp<="1111001"; --3
           when 5 => nums_temp<="0110011"; --4
           when 6 => nums_temp<="1011011"; --5
           
           when 7 => numb_temp<="1111110"; --0
           when 8 => numb_temp<="0110000"; --1
           when 9 => numb_temp<="1101101"; --2
           when 10=> numb_temp<="1111001"; --3
           when 11=> numb_temp<="0110011"; --4
           when 12=> numb_temp<="1011011"; --5
           when 13=> numb_temp<="1011111"; --6
           when 14=> numb_temp<="1110000"; --7
           when 15=> numb_temp<="1111111"; --8
           when 16=> numb_temp<="1111011"; --9
           when others=>NULL;
		end case;
	elsif(state_in="1111") then -- set finish: nexie reinit
		nums_temp<="1111110";
		numb_temp<="1111110";
	else
		case (sel61/10) is
			when 0 => nums_temp<="1111110";--0
			when 1 => nums_temp<="0110000";--1
			when 2 => nums_temp<="1101101";--2
			when 3 => nums_temp<="1111001";--3
			when 4 => nums_temp<="0110011";--4
			when 5 => nums_temp<="1011011";--5
			when 6 => nums_temp<="1011111";--6
			when others=>NULL;
		end case;
		case (sel61 mod 10) is
			when 0 => numb_temp<="1111110";--0
			when 1 => numb_temp<="0110000";--1
			when 2 => numb_temp<="1101101";--2
			when 3 => numb_temp<="1111001";--3
			when 4 => numb_temp<="0110011";--4
			when 5 => numb_temp<="1011011";--5
			when 6 => numb_temp<="1011111";--6
			when 7 => numb_temp<="1110000";--7
			when 8 => numb_temp<="1111111";--8
			when 9 => numb_temp<="1111011";--9
			when others=>NULL;
		end case;
	end if;
	nums<=nums_temp;
	numb<=numb_temp;
end if;
end process;
		
       

p2:process(clkin,state_in,sel61)
variable count:integer range 0 to 7;
	begin
	   if (clkin'event AND clkin='1') then
			if(state_in="0000" or state_in="0001") then cat<="11111111"; -- seg off
			else
			case count is
			when 0 =>cat<="11111101";count:=1; -- seg output destin
				if(state_in="0010")then
					seg<=seg_temp1;
				elsif(state_in="0011")then
					seg<=seg_temp3;
				elsif(state_in="0100" )then
					seg<=seg_temp5;
				elsif(state_in="1010" )then
					seg<=seg_temp9;
				elsif(state_in="1011" )then
					seg<=seg_temp11;
				elsif(state_in="1100" )then
					seg<=seg_temp13;
				elsif(state_in="1111" )then
					seg<="1111110";
				elsif(state_in="0101" or state_in="0110" or state_in="0111" or state_in="1000")then
					-- counting down
					case (sel61/10) is
						when 0 => seg_temp7<="1111110";--0
						when 1 => seg_temp7<="0110000";--1
						when 2 => seg_temp7<="1101101";--2
						when 3 => seg_temp7<="1111001";--3
						when 4 => seg_temp7<="0110011";--4
						when 5 => seg_temp7<="1011011";--5
						when 6 => seg_temp7<="1011111";--6
						when others=>NULL;
					end case;
					seg<=seg_temp7;
				end if;
			when 1=>cat<="11111110";count:=2;
				if(state_in="0010")then
					seg<=seg_temp2;
				elsif(state_in="0011")then
					seg<=seg_temp4;
				elsif(state_in="0100")then
					seg<=seg_temp6;
				elsif(state_in="1010")then
					seg<=seg_temp10;
				elsif(state_in="1011")then
					seg<=seg_temp12;
				elsif(state_in="1100")then
					seg<=seg_temp14;
				elsif(state_in="1111" )then
					seg<="1010111";
				elsif(state_in="0101" or state_in="0110" or state_in="0111" or state_in="1000")then
				 -- count down start || alert
					case (sel61 mod 10) is
						when 0 => seg_temp8<="1111110";--0
						when 1 => seg_temp8<="0110000";--1
						when 2 => seg_temp8<="1101101";--2
						when 3 => seg_temp8<="1111001";--3
						when 4 => seg_temp8<="0110011";--4
						when 5 => seg_temp8<="1011011";--5
						when 6 => seg_temp8<="1011111";--6
						when 7 => seg_temp8<="1110000";--7
						when 8 => seg_temp8<="1111111";--8
						when 9 => seg_temp8<="1111011";--9
						when others=>NULL;
					end case;
					seg<=seg_temp8;
				end if;
			when 2 =>
				case (cnt_u2 mod 10) is
					when 0 => seg_tempnb<="1111110";--0
					when 1 => seg_tempnb<="0110000";--1
					when 2 => seg_tempnb<="1101101";--2
					when 3 => seg_tempnb<="1111001";--3
					when 4 => seg_tempnb<="0110011";--4
					when 5 => seg_tempnb<="1011011";--5
					when 6 => seg_tempnb<="1011111";--6
					when 7 => seg_tempnb<="1110000";--7
					when 8 => seg_tempnb<="1111111";--8
					when 9 => seg_tempnb<="1111011";--9
					when others=>NULL;
				end case;
				cat <= "10111111"; seg<=seg_tempnb; count:=3;
			when 3 =>
				case ((cnt_u2/10) mod 10) is
					when 0 => seg_tempna<="1111110";--0
					when 1 => seg_tempna<="0110000";--1
					when 2 => seg_tempna<="1101101";--2
					when 3 => seg_tempna<="1111001";--3
					when 4 => seg_tempna<="0110011";--4
					when 5 => seg_tempna<="1011011";--5
					when 6 => seg_tempna<="1011111";--6
					when 7 => seg_tempna<="1110000";--7
					when 8 => seg_tempna<="1111111";--8
					when 9 => seg_tempna<="1111011";--9
					when others=>NULL;
				end case;
				cat <= "01111111"; seg<=seg_tempna; count:=4;
			when 4 =>
				case (cnt_u3 mod 10) is
					when 0 => seg_tempnb<="1111110";--0
					when 1 => seg_tempnb<="0110000";--1
					when 2 => seg_tempnb<="1101101";--2
					when 3 => seg_tempnb<="1111001";--3
					when 4 => seg_tempnb<="0110011";--4
					when 5 => seg_tempnb<="1011011";--5
					when 6 => seg_tempnb<="1011111";--6
					when 7 => seg_tempnb<="1110000";--7
					when 8 => seg_tempnb<="1111111";--8
					when 9 => seg_tempnb<="1111011";--9
					when others=>NULL;
				end case;
				cat <= "11101111"; seg<=seg_tempnb; count:=5;
			when 5 =>
				case ((cnt_u3/10) mod 10) is
					when 0 => seg_tempna<="1111110";--0
					when 1 => seg_tempna<="0110000";--1
					when 2 => seg_tempna<="1101101";--2
					when 3 => seg_tempna<="1111001";--3
					when 4 => seg_tempna<="0110011";--4
					when 5 => seg_tempna<="1011011";--5
					when 6 => seg_tempna<="1011111";--6
					when 7 => seg_tempna<="1110000";--7
					when 8 => seg_tempna<="1111111";--8
					when 9 => seg_tempna<="1111011";--9
					when others=>NULL;
				end case;
				cat <= "11011111"; seg<=seg_tempna; count:=6;
			when 6 =>
				case (cnt_u1 mod 10) is
					when 0 => seg_tempnb<="1111110";--0
					when 1 => seg_tempnb<="0110000";--1
					when 2 => seg_tempnb<="1101101";--2
					when 3 => seg_tempnb<="1111001";--3
					when 4 => seg_tempnb<="0110011";--4
					when 5 => seg_tempnb<="1011011";--5
					when 6 => seg_tempnb<="1011111";--6
					when 7 => seg_tempnb<="1110000";--7
					when 8 => seg_tempnb<="1111111";--8
					when 9 => seg_tempnb<="1111011";--9
					when others=>NULL;
				end case;
				cat <= "11111011"; seg<=seg_tempnb; count:=7;
			when 7 =>
				case ((cnt_u1/10) mod 10) is
					when 0 => seg_tempna<="1111110";--0
					when 1 => seg_tempna<="0110000";--1
					when 2 => seg_tempna<="1101101";--2
					when 3 => seg_tempna<="1111001";--3
					when 4 => seg_tempna<="0110011";--4
					when 5 => seg_tempna<="1011011";--5
					when 6 => seg_tempna<="1011111";--6
					when 7 => seg_tempna<="1110000";--7
					when 8 => seg_tempna<="1111111";--8
					when 9 => seg_tempna<="1111011";--9
					when others=>NULL;
				end case;
				cat <= "11110111"; seg<=seg_tempna; count:=0;
			when others =>null;
			end case;
			end if;
		end if;
end process p2;

p3:process(clkin,state_in)
   begin
   if pre/=C then
       if (clkin'event AND clkin='1') then
           pre<=C;
         if(state_in="0000")then -- poweroff: reset
           seg_temp1<="1111110";
           seg_temp2<="1111110";
           seg_temp3<="1111110";
           seg_temp4<="1111110";
           seg_temp5<="1111110";
           seg_temp6<="1111110";
		 
		 -- time set input
		 elsif(state_in="0010")then
       case C is
           when 1 => seg_temp1<="1111110";--0
           when 2 => seg_temp1<="0110000";--1
           when 3 => seg_temp1<="1101101";--2
           when 4 => seg_temp1<="1111001";--3
           when 5 => seg_temp1<="0110011";--4
           when 6 => seg_temp1<="1011011";--5
           
           when 7 => seg_temp2<="1111110";--0
           when 8 => seg_temp2<="0110000";--1
           when 9 => seg_temp2<="1101101";--2
           when 10=> seg_temp2<="1111001";--3
           when 11=> seg_temp2<="0110011";--4
           when 12=> seg_temp2<="1011011";--5
           when 13=> seg_temp2<="1011111";--6
           when 14=> seg_temp2<="1110000";--7
           when 15=> seg_temp2<="1111111";--8
           when 16=> seg_temp2<="1111011";--9
           when others=>NULL;
       end case;
		 elsif(state_in="0011")then
		 case C is
           when 1 => seg_temp3<="1111110";--0
           when 2 => seg_temp3<="0110000";--1
           when 3 => seg_temp3<="1101101";--2
           when 4 => seg_temp3<="1111001";--3
           when 5 => seg_temp3<="0110011";--4
           when 6 => seg_temp3<="1011011";--5
           
           when 7 => seg_temp4<="1111110";--0
           when 8 => seg_temp4<="0110000";--1
           when 9 => seg_temp4<="1101101";--2
           when 10=> seg_temp4<="1111001";--3
           when 11=> seg_temp4<="0110011";--4
           when 12=> seg_temp4<="1011011";--5
           when 13=> seg_temp4<="1011111";--6
           when 14=> seg_temp4<="1110000";--7
           when 15=> seg_temp4<="1111111";--8
           when 16=> seg_temp4<="1111011";--9
           when others=>NULL;
       end case;
		 elsif(state_in="0100")then
		 case C is
           when 1 => seg_temp5<="1111110";--0
           when 2 => seg_temp5<="0110000";--1
           when 3 => seg_temp5<="1101101";--2
           when 4 => seg_temp5<="1111001";--3
           when 5 => seg_temp5<="0110011";--4
           when 6 => seg_temp5<="1011011";--5
           
           when 7 => seg_temp6<="1111110";--0
           when 8 => seg_temp6<="0110000";--1
           when 9 => seg_temp6<="1101101";--2
           when 10=> seg_temp6<="1111001";--3
           when 11=> seg_temp6<="0110011";--4
           when 12=> seg_temp6<="1011011";--5
           when 13=> seg_temp6<="1011111";--6
           when 14=> seg_temp6<="1110000";--7
           when 15=> seg_temp6<="1111111";--8
           when 16=> seg_temp6<="1111011";--9
           when others=>NULL;
       end case;
       elsif(state_in="1010")then
		 case C is
           when 1 => seg_temp9<="1111110";--0
           when 2 => seg_temp9<="0110000";--1
           when 3 => seg_temp9<="1101101";--2
           when 4 => seg_temp9<="1111001";--3
           when 5 => seg_temp9<="0110011";--4
           when 6 => seg_temp9<="1011011";--5
           
           when 7 => seg_temp10<="1111110";--0
           when 8 => seg_temp10<="0110000";--1
           when 9 => seg_temp10<="1101101";--2
           when 10=> seg_temp10<="1111001";--3
           when 11=> seg_temp10<="0110011";--4
           when 12=> seg_temp10<="1011011";--5
           when 13=> seg_temp10<="1011111";--6
           when 14=> seg_temp10<="1110000";--7
           when 15=> seg_temp10<="1111111";--8
           when 16=> seg_temp10<="1111011";--9
           when others=>NULL;
       end case;
       elsif(state_in="1011")then
		 case C is
           when 1 => seg_temp11<="1111110";--0
           when 2 => seg_temp11<="0110000";--1
           when 3 => seg_temp11<="1101101";--2
           when 4 => seg_temp11<="1111001";--3
           when 5 => seg_temp11<="0110011";--4
           when 6 => seg_temp11<="1011011";--5
           
           when 7 => seg_temp12<="1111110";--0
           when 8 => seg_temp12<="0110000";--1
           when 9 => seg_temp12<="1101101";--2
           when 10=> seg_temp12<="1111001";--3
           when 11=> seg_temp12<="0110011";--4
           when 12=> seg_temp12<="1011011";--5
           when 13=> seg_temp12<="1011111";--6
           when 14=> seg_temp12<="1110000";--7
           when 15=> seg_temp12<="1111111";--8
           when 16=> seg_temp12<="1111011";--9
           when others=>NULL;
       end case;
       elsif(state_in="1100")then
		 case C is
           when 1 => seg_temp13<="1111110";--0
           when 2 => seg_temp13<="0110000";--1
           when 3 => seg_temp13<="1101101";--2
           when 4 => seg_temp13<="1111001";--3
           when 5 => seg_temp13<="0110011";--4
           when 6 => seg_temp13<="1011011";--5
           
           when 7 => seg_temp14<="1111110";--0
           when 8 => seg_temp14<="0110000";--1
           when 9 => seg_temp14<="1101101";--2
           when 10=> seg_temp14<="1111001";--3
           when 11=> seg_temp14<="0110011";--4
           when 12=> seg_temp14<="1011011";--5
           when 13=> seg_temp14<="1011111";--6
           when 14=> seg_temp14<="1110000";--7
           when 15=> seg_temp14<="1111111";--8
           when 16=> seg_temp14<="1111011";--9
           when others=>NULL;
       end case;
		 end if;
       end if;
   end if;
   end process p3;
   

	
p4:process(clk_div, state_in, sel61) -- %61 counter
begin
if(state_in="0000")then
		sel61<=0;
elsif(state_in="0101" or state_in="0110" or state_in="0111" or state_in="1000")then
	if(clk_div'event and clk_div='1') then
		sel61<=sel61+1;
	end if;
	if(sel61=61)then
		sel61<=0;
	end if;
	if(state_in="0000")then
		sel61<=0;
	end if;
	
end if;
end process p4;
end a;


