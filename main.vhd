LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY main is
	port(
		clkin:in std_logic;
		b0:in std_logic; -- btn
		b1:in std_logic;
		b2:in std_logic;
		b3:in std_logic;
		b4:in std_logic;
		b5:in std_logic;
		b6:in std_logic;
		nums:in std_logic_vector(6 downto 0);
		numb:in std_logic_vector(6 downto 0);
		dis1:out std_logic_vector(6 downto 0);
		dis2:out std_logic_vector(6 downto 0);
		dis3:out std_logic_vector(6 downto 0);
		dis4:out std_logic_vector(6 downto 0);
		dis5:out std_logic_vector(6 downto 0);
		dis6:out std_logic_vector(6 downto 0);
		dis7:out std_logic_vector(6 downto 0);
		dis8:out std_logic_vector(6 downto 0);
		dis9:out std_logic_vector(6 downto 0);
		dis10:out std_logic_vector(6 downto 0);
		dis11:out std_logic_vector(6 downto 0);
		dis12:out std_logic_vector(6 downto 0);
		--seg_un:out integer range 0 to 1000000:=0;
		seg_u1:out integer range 0 to 31;
		seg_u2:out integer range 0 to 31;
		seg_u3:out integer range 0 to 31;
		--seg_un:out std_logic_vector(6 downto 0);
		state_out:out std_logic_vector(3 downto 0)
	);
END main;

ARCHITECTURE behave of main is
signal count_b0:integer range 0 to 15:=0;
signal count_b1:integer range 0 to 2 :=0;
signal count_b2:integer range 0 to 1 :=0;
signal count_b4:integer range 0 to 2 :=0;
signal count_b5:integer range 0 to 3 :=0;
signal count_b6:integer range 0 to 1 :=0;
--signal count_un:integer range 0 to 999999:=0;
signal count_u1:integer range 0 to 31:=0;
signal count_u2:integer range 0 to 31:=0;
signal count_u3:integer range 0 to 31:=0;
--signal count_un:std_logic_vector (6 downto 0):="000000";
signal cur_state:std_logic_vector(3 downto 0):="0000";
signal rs1:std_logic_vector(6 downto 0):="0000000";
signal rs2:std_logic_vector(6 downto 0):="0000000";
signal rb1:std_logic_vector(6 downto 0):="0000000";
signal rb2:std_logic_vector(6 downto 0):="0000000";
signal gs1:std_logic_vector(6 downto 0):="0000000";
signal gs2:std_logic_vector(6 downto 0):="0000000";
signal gb1:std_logic_vector(6 downto 0):="0000000";
signal gb2:std_logic_vector(6 downto 0):="0000000";
signal ys1:std_logic_vector(6 downto 0):="0000000";
signal ys2:std_logic_vector(6 downto 0):="0000000";
signal yb1:std_logic_vector(6 downto 0):="0000000";
signal yb2:std_logic_vector(6 downto 0):="0000000";
signal temp1:std_logic_vector(3 downto 0):="0000";

begin
 -- btn counter --
	process(b0)
	begin
	if(b0'event and b0 = '1')then
	        if count_b0=15 then
				count_b0<=0;
			else
			    count_b0<=count_b0+1;
			end if;	
	end if;
	end process;
	
	process(b1)
	begin
	if((count_b0 mod 2)=0) then
			count_b1<=0;
	elsif(b1'event and b1 = '1')then
	        if count_b1=2 then
				count_b1<=1;
			else
			    count_b1<=count_b1+1;
			end if;	
	end if;
	end process;
	
	process(b4)
	begin
	if((count_b0 mod 2)=0) then
			count_b4<=0;
	elsif(b4'event and b4 = '1')then
	        if count_b4=2 then
				count_b4<=1;
			else
			    count_b4<=count_b4+1;
			end if;	
	end if;
	end process;
	
	process(b5)
	begin
	if((count_b0 mod 2)=0) then
			count_b5<=0;
	elsif(b5'event and b5 = '1')then
	        if count_b5=2 then
				count_b5<=1;
			else
			    count_b5<=count_b5+1;
			end if;	
	end if;
	end process;
	
	process(b2)
	begin
	if((count_b0 mod 2)=0) then
			count_b2<=0;
	elsif(b2'event and b2 = '1')then
	        if count_b2=1 then
				count_b2<=0;
			else
			    count_b2<=count_b2+1;
			end if;	
	end if;
	end process;
	
	process(b6)
	begin
	if((count_b0 mod 2)=0) then
			count_b6<=0;
	elsif(b6'event and b6 = '1')then
	        if count_b6=1 then
				count_b6<=0;
			else
			    count_b6<=count_b6+1;
			end if;	
	end if;
	end process;
	

-- state machine status description:
-- standard group:
-- 0010 :  2 : set first  time for R box
-- 0011 :  3 : set first  time for B box
-- 0100 :  4 : set first  time for Y box
-- 1010 : 10 : set second time for R box
-- 1011 : 11 : set second time for B box
-- 1100 : 12 : set second time for Y box
-- 0101 :  5 : count down start
-- 0110 :  6 : R box alert triggered
-- 0111 :  7 : G box alert triggered
-- 1000 :  8 : Y box alert triggered
-- specialized group:
-- 0000 :  0 : power off
-- 0001 :  1 : power on
-- 1111 : 31 : set finish


process(cur_state,clkin,count_b0,count_b1,count_b2,nums,numb,b3)
begin
	if(clkin'event and clkin='1')then
		case cur_state is
			when "0000"=>
				if((count_b0 mod 2)=1)then
					cur_state<="0001";
				end if;
			when"0001"=>
				if(count_b1=1)then
					cur_state<="0010";
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"0010"=>
				if(count_b1=2)then
					cur_state<="1010";
				elsif(count_b4=1)then
					cur_state<="0011";
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"1010"=>
				if(count_b4=1)then
					cur_state<="0011";
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"0011"=>
				if(count_b5=1)then
					cur_state<="0100";
				elsif(count_b4=2)then
					cur_state<="1011";
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"1011"=>
				if(count_b5=1)then
					cur_state<="0100";
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"0100"=>
				if(count_b5=2)then
					cur_state<="1100";
				elsif(count_b6=1)then
					cur_state<="1111";
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"1100"=>
				if(count_b6=1)then
					cur_state<="1111";
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000";
				end if;	
			when"1111"=>
				if(count_b2=1)then
					cur_state<="0101";
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"0101"=>
				if((nums=rs1 and numb=rb1)or(nums=rs2 and numb=rb2))then
					cur_state<="0110";
				elsif((nums=gs1 and numb=gb1)or(nums=gs2 and numb=gb2)) then
					cur_state<="0111";
				elsif((nums=ys1 and numb=yb1)or(nums=ys2 and numb=yb2)) then
					cur_state<="1000";
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000";
				else
					cur_state<="0101";
				end if;
			when"0110"=>
				if((nums=gs1 and numb=gb1)or(nums=gs2 and numb=gb2)) then
					cur_state<="0111"; count_u1<=count_u1+1;
				elsif((nums=ys1 and numb=yb1)or(nums=ys2 and numb=yb2)) then
					cur_state<="1000"; count_u1<=count_u1+1;
				elsif(nums="1011111" and numb="1111110") then
					cur_state<="0101"; count_u1<=count_u1+1;
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000"; count_u1<=0; count_u2<=0; count_u3<=0;
		        elsif(temp1="0101") then
					cur_state<="0101";
				else
					cur_state<="0110";
				end if;
			when"0111"=>
				if((nums=rs1 and numb=rb1)or(nums=rs2 and numb=rb2))then
					cur_state<="0110"; count_u2<=count_u2+1;
				elsif((nums=ys1 and numb=yb1)or(nums=ys2 and numb=yb2)) then
					cur_state<="1000"; count_u2<=count_u2+1;
				elsif(nums="1011111" and numb="1111110") then
					cur_state<="0101"; count_u2<=count_u2+1;
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000"; count_u1<=0; count_u2<=0; count_u3<=0;
				elsif(temp1="0101") then
					cur_state<="0101";
				else
					cur_state<="0111";
				end if;
			when"1000"=>
				if((nums=rs1 and numb=rb1)or(nums=rs2 and numb=rb2))then
					cur_state<="0110"; count_u3<=count_u3+1;
				elsif((nums=gs1 and numb=gb1)or(nums=gs2 and numb=gb2)) then
					cur_state<="0111"; count_u3<=count_u3+1;
				elsif(nums="1011111" and numb="1111110") then
					cur_state<="0101"; count_u3<=count_u3+1;
				elsif((count_b0 mod 2)=0) then
					cur_state<="0000"; count_u1<=0; count_u2<=0; count_u3<=0;
				elsif(temp1="0101") then
					cur_state<="0101";
				else
					cur_state<="1000";
				end if;
			when others=>null;
		end case;
	end if;
end process;

process(b3,cur_state)
begin
	if(cur_state/="0110" and cur_state/="0111" and cur_state/="1000")then
		temp1<="0000";
	elsif(b3'event and b3='1') then
		if(cur_state="0110" or cur_state="0111" or cur_state="1000") then
			temp1<="0101";
		end if;
	end if;
end process;

--PROCESS (cur_state, clkin) begin
--	if (clkin'event and clkin='1') then
--		if(cur_state="0101" or cur_state="0110" or cur_state="0111" or cur_state="1000") then
--			case count_un is
--				when 0 => seg_un<="1111110";
--				when 1 => seg_un<="0110000";
--				when 2 => seg_un<="1101101";
--				when 3 => seg_un<="1111001";
--				when 4 => seg_un<="0110011";
--				when 5 => seg_un<="1011011";
--				when 6 => seg_un<="1011111";
--				when 7 => seg_un<="1110000";
--				when others=>NULL;
--			end case;
--		else seg_un <= "0000000";
--		end if;
--	end if;
--end process;

dis1 <= rs1;
dis2 <= rb1;
dis3 <= rs2;
dis4 <= rb2;
dis5 <= gs1;
dis6 <= gb1;
dis7 <= gs2;
dis8 <= gb2;
dis9 <= ys1;
dis10<= yb1;
dis11<= ys2;
dis12<= yb2;				

state_out<=cur_state;
--seg_un <= (count_u1*10000)+(count_u2*100)+count_u3;
seg_u1 <= count_u1;
seg_u2 <= count_u2;
seg_u3 <= count_u3;

-- user setup

process(cur_state,clkin)
begin
	if(clkin'event and clkin='1')then
		case cur_state is
			when "0010"=>
				rs1<=nums;rb1<=numb;
			when "1010"=>
				rs2<=nums;rb2<=numb;
			when "0011"=>
				gs1<=nums;gb1<=numb;
			when "1011"=>
				gs2<=nums;gb2<=numb;
			when "0100"=>
				ys1<=nums;yb1<=numb;
			when "1100"=>
				ys2<=nums;yb2<=numb;
			when "0000"=>
				rs1<="0000000";
				rb1<="0000000";
				gs1<="0000000";
				gb1<="0000000";
				ys1<="0000000";
				yb1<="0000000";
				rs2<="0000000";
				rb2<="0000000";
				gs2<="0000000";
				gb2<="0000000";
				ys2<="0000000";
				yb2<="0000000";
			when others=>null;
		end case;
	end if;
end process;	



end behave;