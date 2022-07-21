
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity pc is 
	port ( if_reg: out std_logic_vector(15 downto 0);
			opcode: in std_logic_vector(3 downto 0);
			ins_mem: out std_logic_vector(15 downto 0);
			clk: in std_logic
	);
	end entity;
	
architecture working of pc is 
signal pc: std_logic_vector(15 downto 0) := x"0000"; 
begin
if_reg <=pc; 
ins_mem <= pc;

regs_write: process(clk)
variable a : integer;
begin
 if (rising_edge(clk)) then
	if (not(opcode="1111")) then
		a := to_integer(unsigned(pc)) + 1;
		pc <= std_logic_vector(to_unsigned(a,16));
	end if;
end if;	
end process;
end working;