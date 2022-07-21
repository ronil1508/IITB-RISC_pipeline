library ieee;
use ieee.std_logic_1164.all;
library work;
use ieee.numeric_std.all;

entity alu is
	port(opcode4: in std_logic_vector(3 downto 0);
	 alu_a: in std_logic_vector(15 downto 0);
	 alu_b: in std_logic_vector(15 downto 0);
	 ex_reg: out std_logic_vector(15 downto 0);
	 cz: in std_logic_vector(1 downto 0);
	 no_write: out std_logic
	 );
	 end entity;
	 
architecture working of alu is
signal carry: std_logic:='1';
signal zero: std_logic:='0';
begin
	compute : process(alu_a,alu_b,opcode4, cz)
	variable temp: integer;
	variable temp1: std_logic_vector(15 downto 0);
	begin
	 if (opcode4 = "0001") then
		 --add
		 if(cz="00" or (cz="10" and carry='1') or (cz="01" and zero='1'))then
		 temp := to_integer(unsigned(alu_a)) + to_integer(unsigned(alu_b));
		 no_write<='0';
		 if (temp>65536) then
			carry <= '1';
			ex_reg <= std_logic_vector(to_unsigned(temp-65535,16));
		
		elsif(temp=65536) then
				zero <='1';
				carry <= '1';
				ex_reg <= std_logic_vector(to_unsigned(temp-65535,16));
			else
				zero <='0';
				carry <= '0';
				ex_reg <= std_logic_vector(to_unsigned(temp,16));
			end if;	
			
		elsif(cz="11")then
			--adl
			temp := 2*to_integer(unsigned(alu_a)) + to_integer(unsigned(alu_b));
			no_write<='0';
		 if (temp>65536) then
			carry <= '1';
			ex_reg <= std_logic_vector(to_unsigned(temp-65535,16));
		
		elsif(temp=65536) then
				zero <='1';
				carry <= '1';
				ex_reg <= std_logic_vector(to_unsigned(temp-65535,16));
			else
				zero <='0';
				carry <= '0';
				ex_reg <= std_logic_vector(to_unsigned(temp,16));
			end if;	
			
		else 
			no_write<='1';
		end if;
		elsif(opcode4="0000" or opcode4="0111")then
			temp := to_integer(unsigned(alu_a)) + to_integer(unsigned(alu_b));
		 no_write<='0';
		 if (temp>65536) then
			carry <= '1';
			ex_reg <= std_logic_vector(to_unsigned(temp-65535,16));
		
		elsif(temp=65536) then
				zero <='1';
				carry <= '1';
				ex_reg <= std_logic_vector(to_unsigned(temp,16));
			else
				zero <='0';
				carry <= '0';
				ex_reg <= std_logic_vector(to_unsigned(temp,16));
			end if;	
		
		
	elsif(opcode4 = "0010") then
			 --nand
		 if(cz="00" or (cz="10" and carry='1') or (cz="01" and zero='1'))then
		 temp1 := alu_a nand alu_b;
		 no_write<='0';			
				 if(temp1=x"0000") then
						zero <='1';
						ex_reg <= temp1;
				 else
						zero <='0';
						ex_reg <= temp1;
				 end if;	
		else 
			no_write<='1';
		end if;
			
	end if;
	
	end process;
end working;