library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
	port(
	 exe_out: in std_logic_vector(15 downto 0);
	 opcode5: in std_logic_vector(3 downto 0);
	 clk : in std_logic;
	 ins_addr: in std_logic_vector(15 downto 0);
	 ir_data: out std_logic_vector(15 downto 0);
	 mem_data: out std_logic_vector(15 downto 0)	 
	 );
	 end entity;
	 
architecture working of mem is
	type mem_array is array (0 to 31 ) of std_logic_vector (15 downto 0);
	signal mem_store: mem_array :=(
   x"0000",x"0005", x"0009", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
   x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000"
   ); 
	
	
	signal mem_ins: mem_array := (
	b"0111000001000001", x"FFFF",  x"0000", x"0000",
	x"0000", x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
   x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000");
	begin
	mem_action: process(clk,opcode5)
	begin
	if (rising_edge(clk)) then
		
	end if;	
	end process;
	mem_read: process( opcode5)
	begin
		
	end process;
	mem_data<= mem_store(to_integer(unsigned(exe_out)));
	ir_data <= mem_ins(to_integer(unsigned(ins_addr)));
end working;
	
	
	
	