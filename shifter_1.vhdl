
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity shifter_1 is 
	port (t2: in std_logic_vector(15 downto 0);
			alu_a: out std_logic_vector(15 downto 0);
			state: in std_logic_vector(5 downto 0)
	);
	end entity;
	
architecture working of shifter_1 is
begin
	t2_proc: process(t2)
	variable i: integer;
	begin
	 if (state="000000" or state="000101") then
	 alu_a(0) <= '0';
		 FOR i IN 0 TO 14 LOOP
	        alu_a(i+1) <= t2(i);
	      END LOOP;
	end if;
	end process;
end working;