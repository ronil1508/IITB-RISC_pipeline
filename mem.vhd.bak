library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mem is
	port( t1_addr: in std_logic_vector(15 downto 0);
	t3_addr: in std_logic_vector(15 downto 0);
	 state: in std_logic_vector(5 downto 0);
	 data_t1: in std_logic_vector(15 downto 0);
	 data_t2: in std_logic_vector(15 downto 0);
	 data_2: out std_logic_vector(15 downto 0);
	 ir_data: out std_logic_vector(15 downto 0);
	 ins_addr: in std_logic_vector(15 downto 0);
	 clk : in std_logic
	 );
	 end entity;
	 
architecture working of mem is
	type mem_array is array (0 to 31 ) of std_logic_vector (15 downto 0);
	signal mem_data: mem_array :=(
   x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
   x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000"
   ); 
	
	
	signal mem_ins: mem_array := (
	x"0000", x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
   x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000"
	);
	begin
	mem_action: process(clk)
	begin
	if (falling_edge(clk)) then
	if(state="001101") then
	 mem_data(to_integer(unsigned(t3_addr))) <= data_t2;
	elsif(state="011001") then
		 mem_data(to_integer(unsigned(t1_addr))) <= data_t2;
	end if;
	end if;
	end process;
	mem_read: process(state, t1_addr, t3_addr)
	begin
		if(state ="001110" or state="011001") then
			data_2 <= mem_data(to_integer(unsigned(t1_addr)));
		elsif (state="001010") then
			data_2<= mem_data(to_integer(unsigned(t3_addr)));
		end if;
	end process;
	ir_data <= mem_ins(to_integer(unsigned(ins_addr)));
end working;
	
	
	
	