
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity registers is 
	port (reg_a1: in std_logic_vector(2 downto 0);
			reg_a2: in std_logic_vector(2 downto 0);
			reg_a3: in std_logic_vector(2 downto 0);
			t1: out std_logic_vector(15 downto 0);
			t1_in: in std_logic_vector(15 downto 0);
			t2: out std_logic_vector(15 downto 0);
			t2_in: in std_logic_vector(15 downto 0);
			t3: in std_logic_vector(15 downto 0);
			shift7: in std_logic_vector(15 downto 0); 
			pc_in: in std_logic_vector(15 downto 0);
			pc_out: out std_logic_vector(15 downto 0);
			clk: in std_logic;
			state: in std_logic_vector(5 downto 0)
	);
	end entity;
	
architecture working of registers is 
type mem_array is array (0 to 7 ) of std_logic_vector (15 downto 0);
signal regs: mem_array :=(
   x"0000",x"0000", x"0000", x"0000",
	x"0000",x"0000", x"0000", x"0000"
   ); 
begin

regs_read: process(reg_a1, reg_a2, state)
begin 
	if (state = "000010") then
		t1 <= regs(to_integer(unsigned(reg_a1)));
		t2 <= regs(to_integer(unsigned(reg_a2)));
	elsif (state="001000" or state="100100") then
		t1 <= regs(to_integer(unsigned(reg_a1)));
	elsif (state="001100") then
		t2 <= regs(to_integer(unsigned(reg_a1)));
	elsif (state="011000") then
		t2 <= regs(0);
	elsif (state="011010") then
		t2 <= regs(1);
	elsif (state="011011") then
		t2 <= regs(2);
	elsif (state="011100") then
		t2 <= regs(3);
	elsif (state="011101") then
		t2 <= regs(4);
	elsif (state="011110") then
		t2 <= regs(5);
	elsif (state="011111") then
		t2 <= regs(6);
	elsif (state="100000") then
		t2 <= regs(7);
	elsif(state="100011") then
		pc_out<= regs(to_integer(unsigned(reg_a2)));
	end if;
 end process;
 
regs_write: process(clk)
begin
 if (falling_edge(clk)) then
	if (state = "000100" or state="100111") then
		regs(to_integer(unsigned(reg_a3)))<= t3;
	elsif (state="000111") then
		regs(to_integer(unsigned(reg_a3)))<= shift7;
	elsif (state="001011") then
		regs(to_integer(unsigned(reg_a3))) <= t1_in;
	elsif (state="001111") then	
		regs(0) <= t2_in;
	elsif (state="010001") then	
		regs(1) <= t2_in;
	elsif (state="010010") then	
		regs(2) <= t2_in;
	elsif (state="010011") then	
		regs(3) <= t2_in;
	elsif (state="010100") then	
		regs(4) <= t2_in;
	elsif (state="010101") then	
		regs(5) <= t2_in;
	elsif (state="010110") then	
		regs(6) <= t2_in;
	elsif (state="010111") then	
		regs(7) <= t2_in;
	elsif (state="100010" or state="100011") then	
		regs(to_integer(unsigned(reg_a1))) <= pc_in;
	
	end if;
	end if;
end process;
end working;