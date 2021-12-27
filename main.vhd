LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;

ENTITY main is
	PORT(
		clkin:IN STD_LOGIC;
		b0:IN STD_LOGIC; -- btn
		b1:IN STD_LOGIC;
		b2:IN STD_LOGIC;
		b3:IN STD_LOGIC;
		b4:IN STD_LOGIC;
		b5:IN STD_LOGIC;
		b6:IN STD_LOGIC;
		nums:IN STD_LOGIC_VECTOR(6 downto 0);
		numb:IN STD_LOGIC_VECTOR(6 downto 0);
		dis1:OUT STD_LOGIC_VECTOR(6 downto 0);
		dis2:OUT STD_LOGIC_VECTOR(6 downto 0);
		dis3:OUT STD_LOGIC_VECTOR(6 downto 0);
		dis4:OUT STD_LOGIC_VECTOR(6 downto 0);
		dis5:OUT STD_LOGIC_VECTOR(6 downto 0);
		dis6:OUT STD_LOGIC_VECTOR(6 downto 0);
		dis7:OUT STD_LOGIC_VECTOR(6 downto 0);
		dis8:OUT STD_LOGIC_VECTOR(6 downto 0);
		dis9:OUT STD_LOGIC_VECTOR(6 downto 0);
		dis10:OUT STD_LOGIC_VECTOR(6 downto 0);
		dis11:OUT STD_LOGIC_VECTOR(6 downto 0);
		dis12:OUT STD_LOGIC_VECTOR(6 downto 0);
		--seg_un:OUT INTEGER range 0 to 1000000:=0;
		seg_u1:OUT INTEGER range 0 to 31;
		seg_u2:OUT INTEGER range 0 to 31;
		seg_u3:OUT INTEGER range 0 to 31;
		--seg_un:OUT STD_LOGIC_VECTOR(6 downto 0);
		state_out:OUT STD_LOGIC_VECTOR(3 downto 0)
	);
END main;

ARCHITECTURE behave of main is
SIGNAL cnt_b0:INTEGER range 0 to 15:=0;
SIGNAL cnt_b1:INTEGER range 0 to 2 :=0;
SIGNAL cnt_b2:INTEGER range 0 to 1 :=0;
SIGNAL cnt_b4:INTEGER range 0 to 2 :=0;
SIGNAL cnt_b5:INTEGER range 0 to 3 :=0;
SIGNAL cnt_b6:INTEGER range 0 to 1 :=0;
--SIGNAL cnt_un:INTEGER range 0 to 999999:=0;
SIGNAL cnt_u1:INTEGER range 0 to 31:=0;
SIGNAL cnt_u2:INTEGER range 0 to 31:=0;
SIGNAL cnt_u3:INTEGER range 0 to 31:=0;
--SIGNAL cnt_un:STD_LOGIC_VECTOR (6 downto 0):="000000";
SIGNAL cur_state:STD_LOGIC_VECTOR(3 downto 0):="0000";
SIGNAL rs1:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL rs2:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL rb1:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL rb2:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL gs1:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL gs2:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL gb1:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL gb2:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL ys1:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL ys2:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL yb1:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL yb2:STD_LOGIC_VECTOR(6 downto 0):="0000000";
SIGNAL temp1:STD_LOGIC_VECTOR(3 downto 0):="0000";

begin
 -- btn cnter --
	PROCESS(b0)
	begin
	if(b0'event and b0 = '1')then
	        if cnt_b0=15 then
				cnt_b0<=0;
			else
			    cnt_b0<=cnt_b0+1;
			end if;	
	end if;
	end PROCESS;
	
	PROCESS(b1)
	begin
	if((cnt_b0 mod 2)=0) then
			cnt_b1<=0;
	elsif(b1'event and b1 = '1')then
	        if cnt_b1=2 then
				cnt_b1<=1;
			else
			    cnt_b1<=cnt_b1+1;
			end if;	
	end if;
	end PROCESS;
	
	PROCESS(b4)
	begin
	if((cnt_b0 mod 2)=0) then
			cnt_b4<=0;
	elsif(b4'event and b4 = '1')then
	        if cnt_b4=2 then
				cnt_b4<=1;
			else
			    cnt_b4<=cnt_b4+1;
			end if;	
	end if;
	end PROCESS;
	
	PROCESS(b5)
	begin
	if((cnt_b0 mod 2)=0) then
		cnt_b5<=0;
	elsif(b5'event and b5 = '1')then
		if cnt_b5=2 then
			cnt_b5<=1;
		else
			cnt_b5<=cnt_b5+1;
		end if;	
	end if;
	end PROCESS;
	
	PROCESS(b2)
	begin
	if((cnt_b0 mod 2)=0) then
			cnt_b2<=0;
	elsif(b2'event and b2 = '1')then
	        if cnt_b2=1 then
				cnt_b2<=0;
			else
			    cnt_b2<=cnt_b2+1;
			end if;	
	end if;
	end PROCESS;
	
	PROCESS(b6)
	begin
	if((cnt_b0 mod 2)=0) then
			cnt_b6<=0;
	elsif(b6'event and b6 = '1')then
	        if cnt_b6=1 then
				cnt_b6<=0;
			else
			    cnt_b6<=cnt_b6+1;
			end if;	
	end if;
	end PROCESS;
	

-- state machINe status description:
-- standard group:
-- 0010 :  2 : set first  time for R box
-- 0011 :  3 : set first  time for B box
-- 0100 :  4 : set first  time for Y box
-- 1010 : 10 : set second time for R box
-- 1011 : 11 : set second time for B box
-- 1100 : 12 : set second time for Y box
-- 0101 :  5 : cnt down start
-- 0110 :  6 : R box alert triggered
-- 0111 :  7 : G box alert triggered
-- 1000 :  8 : Y box alert triggered
-- specialized group:
-- 0000 :  0 : power off
-- 0001 :  1 : power on
-- 1111 : 31 : set finish


PROCESS(cur_state,clkin,cnt_b0,cnt_b1,cnt_b2,nums,numb,b3)
begin
	if(clkin'event and clkin='1')then
		case cur_state is
			when "0000"=>
				if((cnt_b0 mod 2)=1)then
					cur_state<="0001";
				end if;
			when"0001"=>
				if(cnt_b1=1)then
					cur_state<="0010";
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"0010"=>
				if(cnt_b1=2)then
					cur_state<="1010";
				elsif(cnt_b4=1)then
					cur_state<="0011";
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"1010"=>
				if(cnt_b4=1)then
					cur_state<="0011";
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"0011"=>
				if(cnt_b5=1)then
					cur_state<="0100";
				elsif(cnt_b4=2)then
					cur_state<="1011";
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"1011"=>
				if(cnt_b5=1)then
					cur_state<="0100";
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"0100"=>
				if(cnt_b5=2)then
					cur_state<="1100";
				elsif(cnt_b6=1)then
					cur_state<="1111";
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"1100"=>
				if(cnt_b6=1)then
					cur_state<="1111";
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000";
				end if;	
			when"1111"=>
				if(cnt_b2=1)then
					cur_state<="0101";
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000";
				end if;
			when"0101"=>
				if((nums=rs1 and numb=rb1)or(nums=rs2 and numb=rb2))then
					cur_state<="0110";
				elsif((nums=gs1 and numb=gb1)or(nums=gs2 and numb=gb2)) then
					cur_state<="0111";
				elsif((nums=ys1 and numb=yb1)or(nums=ys2 and numb=yb2)) then
					cur_state<="1000";
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000";
				else
					cur_state<="0101";
				end if;
			when"0110"=>
				if((nums=gs1 and numb=gb1)or(nums=gs2 and numb=gb2)) then
					cur_state<="0111"; cnt_u1<=cnt_u1+1;
				elsif((nums=ys1 and numb=yb1)or(nums=ys2 and numb=yb2)) then
					cur_state<="1000"; cnt_u1<=cnt_u1+1;
				elsif(nums="1011011" and numb="1111011") then
					cur_state<="0101"; cnt_u1<=cnt_u1+1;
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000"; cnt_u1<=0; cnt_u2<=0; cnt_u3<=0;
		        elsif(temp1="0101") then
					cur_state<="0101";
				else
					cur_state<="0110";
				end if;
			when"0111"=>
				if((nums=rs1 and numb=rb1)or(nums=rs2 and numb=rb2))then
					cur_state<="0110"; cnt_u2<=cnt_u2+1;
				elsif((nums=ys1 and numb=yb1)or(nums=ys2 and numb=yb2)) then
					cur_state<="1000"; cnt_u2<=cnt_u2+1;
				elsif(nums="1011011" and numb="1111011") then
					cur_state<="0101"; cnt_u2<=cnt_u2+1;
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000"; cnt_u1<=0; cnt_u2<=0; cnt_u3<=0;
				elsif(temp1="0101") then
					cur_state<="0101";
				else
					cur_state<="0111";
				end if;
			when"1000"=>
				if((nums=rs1 and numb=rb1)or(nums=rs2 and numb=rb2))then
					cur_state<="0110"; cnt_u3<=cnt_u3+1;
				elsif((nums=gs1 and numb=gb1)or(nums=gs2 and numb=gb2)) then
					cur_state<="0111"; cnt_u3<=cnt_u3+1;
				elsif(nums="1011011" and numb="1111011") then
					cur_state<="0101"; cnt_u3<=cnt_u3+1;
				elsif((cnt_b0 mod 2)=0) then
					cur_state<="0000"; cnt_u1<=0; cnt_u2<=0; cnt_u3<=0;
				elsif(temp1="0101") then
					cur_state<="0101";
				else
					cur_state<="1000";
				end if;
			when others=>null;
		end case;
	end if;
end PROCESS;

PROCESS(b3,cur_state)
begin
	if(cur_state/="0110" and cur_state/="0111" and cur_state/="1000")then
		temp1<="0000";
	elsif(b3'event and b3='1') then
		if(cur_state="0110" or cur_state="0111" or cur_state="1000") then
			temp1<="0101";
		end if;
	end if;
end PROCESS;

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
--seg_un <= (cnt_u1*10000)+(cnt_u2*100)+cnt_u3;
seg_u1 <= cnt_u1;
seg_u2 <= cnt_u2;
seg_u3 <= cnt_u3;

-- USEr setup

PROCESS(cur_state,clkin)
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
end PROCESS;	



end behave;