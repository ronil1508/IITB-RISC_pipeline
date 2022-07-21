
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ins_setter is
port(   reset,clock:in std_logic;
        next_state: in std_logic_vector(5 downto 0);
		  state: out std_logic_vector(5 downto 0)
		  );
end ins_setter;

architecture working of ins_setter is
begin

clock_proc:process(clock,reset)
begin
    if(clock='1' and clock' event) then
        if(reset='1') then
            state<="000000";
        else
            state<=next_state;
        end if;
    end if;
    
end process;

end working;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity ins_decoder is
port(
        next_state: out std_logic_vector(5 downto 0);
		  state: in std_logic_vector(5 downto 0);
		  op_code: in std_logic_vector(3 downto 0);
		  cz: in std_logic_vector(1 downto 0);
		  imm: in std_logic_vector(8 downto 0);
		  op_out: out std_logic_vector(3 downto 0);
		  carry: in std_logic;
		  zero: in std_logic
		  );
end ins_decoder;

architecture working of ins_decoder is
signal i:integer := 1;
signal j:integer := 0;
begin
op_out<=op_code;
next_state_process: process(state)

begin
	case state is
	when "111111"=>
		next_state<="111111";
	when "111100" =>
		if (op_code = "1111") then
		next_state<= "111111";
    	
		elsif (op_code="0001") then
			 if(cz = "01") then
				if(carry = '1') then
					next_state<= "000010";
				else 
					next_state<= "000001";
					end if;
			 elsif(cz="10")	then
				if(zero = '1') then
					next_state <= "000010";
				else
					next_state <= "000001";
					end if;
		     else
					next_state <= "000010";
				end if;	
				

		
      elsif(op_code="0000" or op_code="1000" or op_code="1100" or op_code="1101") then
		next_state <= "000010";
		
		elsif( op_code="0010") then
			 if(cz = "01") then
				if(carry = '1') then
					next_state<= "000010";
				else 
					next_state<= "000001";
					end if;
			 elsif(cz="10")	then
				if(zero = '1') then
					next_state <= "000010";
				else
					next_state <= "000001";
					end if;
		     else
					next_state <= "000010";
				end if;	
		
		
		elsif (op_code="0011") then
		next_state <= "000111";
				 
		 elsif (op_code="0111" or op_code="0101") then
		next_state <= "001000";
		
		
		
			elsif (op_code="1001") then
		next_state <= "100010";
		
		
			elsif (op_code="1010") then
		next_state <= "100011";
		
		
			elsif (op_code="1011") then
		next_state <= "100100";
		end if;
		
	when "000001"=>--s1
		next_state<= "111100";
	   
		
		
	when "000010"=>--s2
	
		if (op_code="0001") then
			if(cz="11") then
				next_state <= "000101";
			else 
			
			next_state <="000011";
			end if;
		
		
		elsif (op_code="0000") then
		next_state <= "000110";
		
		
		elsif(op_code="0010") then
		next_state <="101000";

		
		elsif(op_code="1000") then
		next_state <="101001";
		
		
		elsif(op_code="1100") then
		if(imm(0) = '1') then
		next_state <="001110";
		else
		next_state <= "010000";
		end if;
		
		
		elsif(op_code="1101") then
		if(imm(0) = '1') then
		next_state <="011000";
		else
		next_state <= "010000";
		end if;
		
		end if;
	
	
	when "000011"=> --s3
		if (op_code="0001") then
			next_state <= "000100";
		end if;
		
		
	
	when "000100"=> --s4
		if (op_code="0001" or op_code="0010") then
			next_state <= "000001";
		end if;
		
		
	when "000101"=>--s5
		if (op_code="0001") then
			next_state <= "000100";
		end if;
		
		
		
	when "000110"=>--s6
		if (op_code="0000") then
			next_state <= "100111";	
		elsif(op_code="0111") then
			next_state <="001010";	
		end if;
		
		
	
	when "000111"=> --s7
			next_state <="000001";
			
	when "001000"=> --s8
		 if(op_code="0111") then
			next_state <="000110";
		 elsif(op_code="0101") then
			next_state <="001100";
		 end if;
		
	when "001010"=> --s10
  		 if(op_code="0111") then
			next_state <="001011";
		 end if;
			
			
	when "001011"=> --s11
		if(op_code="0111") then
			next_state <="000001";
		end if;
			
			
	when "001100"=> --s12
		if(op_code="0101") then
			next_state <="001101";
		end if;
			
	when "001101"=> --s13
		if(op_code="0101") then
			next_state <="000001";
		end if;
			
	when "001110" => --s14
		if(op_code="1100") then
			
			j<=i-1;
				if(j=0)then
				next_state<="001111";
				elsif(j=1)then
				next_state<="010001";
				elsif(j=2)then
				next_state<="010010";
				elsif(j=3)then
				next_state<="010011";
				elsif(j=4)then
				next_state<="010100";
				elsif(j=5)then
				next_state<="010101";
				elsif(j=6)then
				next_state<="010110";
				elsif(j=7)then
				next_state<="010111";
				end if;
			--j:=j+1;		
		--	if(j>7) then
			--j:=0;
			--end if;
		end if;
		
		when "010000" => --S16
		if(op_code="1100") then
			
			if(imm(i)='1')then
			i<=i+1;
			next_state<="001110";
			elsif(imm(i)='0') then
			i<=i+1;
			next_state<="010000";

			end if;
			
			if(i>7)then	
			i<=1;
			end if;
		elsif(op_code="1101")then
			if(imm(i)='1')then
				if(i=1)then
				next_state<="011010";
				elsif(i=2)then
				next_state<="011011";
				elsif(i=3)then
				next_state<="011100";
				elsif(i=4)then
				next_state<="011101";
				elsif(i=5)then
				next_state<="011110";
				elsif(i=6)then
				next_state<="011111";
				elsif(i=7)then
				next_state<="100000";
				end if;
			i<=i+1;
			else
			next_state<="010000";
			i<=i+1;
			end if;
			
			if(i>7)then	
			i<=1;
			end if;
		end if;
		
			
		when "001111"|"010001"|"010010"|"010011"|"010100"|"010101"|"010110" => --s15,s17,s18,s19,s20,s21,s22
			if(op_code="1100") then
			next_state <="010000";
			end if;	
			
		when "010111" => --s23
			if(op_code="1100") then
			next_state <="000001";
			end if;	
			
		when "011001"=> --s25
		 if(op_code="1101" and imm(7)='1') then
			next_state <="000001";
		 else
			next_state <="010000";
		 end if;
		 
	
		when "011000"|"011010"|"011011"|"011100"|"011101"|"011110"|"011111"|"100000"=> --s24,s26,s27,s28,s29,s30,s31,s32
		   if(op_code="1101") then
			next_state <="011001";
			end if;
		
		when "100001"=> --s33
		 if(op_code="1000") then
			next_state <="100110";
		 elsif(op_code="1001") then
			next_state <="000001";
		elsif (op_code="1001") then
			next_state <= "100110";
		 end if;
		 
		 
		 when "100010"=> --s34
		 if(op_code="1001") then
			next_state <="100001";
		 end if;
			
		 when "100011"=> --s35
		 if(op_code="1010") then
			next_state <="000001";
		 end if;
		 
		  when "100100"=> --s36
		 if(op_code="1011") then
			next_state <="100101";
		 end if;
		 
		  when "100101"=> --s37
		 if(op_code="1011") then
			next_state <="000001";
		 end if;
		 
		  when "100110"=> --s38
		 if(op_code="1000" or op_code="1001") then
			next_state <="000001";
		 end if;
		 
		  when "100111"=> --s39
		 if(op_code="0000") then
			next_state <="000001";
		 end if;
		 
		  when "101000"=> --s40
		 if(op_code="0010") then
			next_state <="000100";
		 end if;
		 
	when "101001"=> --s41
		 if(op_code="1000") then
			next_state<="101010";
		 end if;
	
	when "101010"=>
		 if(zero = '1') then
			next_state <="100001";
		  else
		   next_state<= "000001";
			end if;

			
	when others =>
		next_state<="000001";
	end case;
end process;


end working;





