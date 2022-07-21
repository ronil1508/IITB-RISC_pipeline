library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ins_dec is
	port (
	ins_dec_reg: in std_logic_vector(15 downto 0);
	clk: in std_logic	;
	op_code: in std_logic_vector(3 downto 0);
		id_reg: out std_logic_vector(15 downto 0)
	) ;
end ins_dec;

architecture working of ins_dec is
signal ins_store: std_logic_vector(15 downto 0);
begin
	write_proc: process(clk)
	begin
	if(rising_edge(clk)) then
			ins_store <= ins_dec_reg;
	end if;
	end process;
	
	read_proc: process(ins_store, op_code)
	begin
	if(op_code="0001" or op_code="0010") then
		id_reg(11 downto 9) <=ins_store(11 downto 9);
		id_reg(8 downto 6)  <= ins_store(8 downto 6);
		id_reg(5 downto 3)  <= ins_store(5 downto 3);
	elsif(op_code="0000") then
		id_reg(11 downto 9) <=ins_store(11 downto 9);
		id_reg(8 downto 6) <= ins_store(8 downto 6);
		id_reg(5 downto 0)<= ins_store(5 downto 0);
	elsif(op_code="0011" or op_code="0111") then
		id_reg<=ins_store;
	end if;
	end process;

end working;