library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ir is
	port (
		reg_1: out std_logic_vector(2 downto 0);
		reg_2: out std_logic_vector(2 downto 0);
		reg_3: out std_logic_vector(2 downto 0);
		shift7: out std_logic_vector(8 downto 0);
		sign_ex: out std_logic_vector(5 downto 0);
		mem: in std_logic_vector(15 downto 0);
		clk: in std_logic;
		state: in std_logic_vector(5 downto 0)
	) ;
end ir;

architecture working of ir is
signal ir_store: std_logic_vector(15 downto 0);
begin
	write_proc: process(clk)
	begin
	if(falling_edge(clk)) then
		if(state="000001") then
			ir_store <= mem;
	end if;
	end if;
	end process;
	
	read_proc: process(ir_store, state)
	begin
	if(state="000010" or state="100011") then
		reg_1<=ir_store(11 downto 9);
		reg_2 <= ir_store(8 downto 6);
	elsif (state="001100") then
		reg_1<= ir_store(11 downto 9);
		sign_ex <= ir_store(5 downto 0);
	elsif(state="100010" or state="100100") then
		reg_1 <= ir_store(11 downto 9);
	elsif(state="000100") then	
		reg_3 <= ir_store(5 downto 3);
	elsif(state="000111") then
		shift7 <= ir_store(8 downto 0);
		reg_3 <= ir_store(11 downto 9);
	elsif(state="000110" or state="100001") then
		sign_ex <= ir_store(5 downto 0);
	elsif(state="001011") then
		reg_3 <= ir_store(11 downto 9);
	elsif(state="001000") then
		reg_1 <= ir_store(8 downto 6);
	elsif (state="100111") then
		reg_3<=ir_store(8 downto 6);
	elsif(state="100101") then
		shift7 <= ir_store(8 downto 0);
	end if;
	end process;

end working;