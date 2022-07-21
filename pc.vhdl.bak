
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pc is 
	port (alu_c: in std_logic_vector(15 downto 0);
			reg: in std_logic_vector(15 downto 0);
			alu_a: out std_logic_vector(15 downto 0);
			data_1: out std_logic_vector(15 downto 0);
			reg_out: out std_logic_vector(15 downto 0);
			state: in std_logic_vector(5 downto 0);
			clk: in std_logic
	);
	end entity;
	
architecture working of pc is 
signal pc: std_logic_vector(15 downto 0) := x"0000"; 
begin

pc_read: process(state)
begin 
	if (state = "000001") then
		data_1 <= pc;
		alu_a <= pc;
	elsif (state="100001" or state="100110") then
		 alu_a <=pc;
	elsif (state="100010" or state="100011") then
		reg_out<=pc;
	end if;
 end process;
 
regs_write: process(clk)
begin
 if (falling_edge(clk)) then
	if (state = "000001" or state="100001" or state="100101" or state="100110") then
		pc <= alu_c;
	elsif (state="100011") then
		pc <= reg;
	end if;
end if;	
end process;
end working;