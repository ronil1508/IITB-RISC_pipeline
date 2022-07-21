library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ir is
	port (
		id: out std_logic_vector(15 downto 0);
		mem: in std_logic_vector(15 downto 0);
		clk: in std_logic;
		opcode1: out std_logic_vector(3 downto 0);
		opcode2: out std_logic_vector(3 downto 0);
		opcode3: out std_logic_vector(3 downto 0);
		opcode4: out std_logic_vector(3 downto 0);
		opcode5: out std_logic_vector(3 downto 0);
		opcode6: out std_logic_vector(3 downto 0);
		cz: out std_logic_vector(1 downto 0)
	) ;
end ir;

architecture working of ir is
type ins_array is array (0 to 5 ) of std_logic_vector (15 downto 0);
signal ir_store: ins_array := ( x"0000", x"0000", x"0000", x"0000", x"0000", x"0000");
begin
	write_proc: process(clk)
	begin
	if(rising_edge(clk) and not(ir_store(5)= x"FFFF")) then
			for i in 4 downto 0 loop
				ir_store(i+1) <= ir_store(i);--used comparator
			end loop;
			if(not(ir_store(0)= x"FFFF")) then
				ir_store(0) <= mem;
			end if;
	end if;
	end process;
	
	id<= ir_store(0);
	opcode1<= ir_store(0)(15 downto 12);
	opcode2<= ir_store(1)(15 downto 12);
	opcode3<= ir_store(2)(15 downto 12);
	opcode4<= ir_store(3)(15 downto 12);
	opcode5<= ir_store(4)(15 downto 12);
	opcode6<= ir_store(5)(15 downto 12);
	cz <= ir_store(3)(1 downto 0);
	

end working;