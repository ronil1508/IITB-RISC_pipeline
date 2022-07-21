library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity if_reg is 
	port(
		ir : in std_logic_vector(15 downto 0);
		id : out std_logic_vector(15 downto 0);
		clk: in std_logic
	);
end if_reg;

architecture working of if_reg is
signal if_store: std_logic_vector(15 downto 0);
begin
	id <= if_store;
	write_proc: process(clk)
	begin 
		if(falling_edge(clk)) then
			if_store<= ir;
		end if;
	end process;
end working;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity id_reg is 
	port(
		id : in std_logic_vector(15 downto 0);
		reg_a1 : out std_logic_vector(2 downto 0);
		reg_a2 : out std_logic_vector(2 downto 0);
		reg_a3 : out std_logic_vector(2 downto 0);
		opcode3: in std_logic_vector(3 downto 0);
		clk: in std_logic;
		imm: out std_logic_vector(5 downto 0);
		reg_rd: out std_logic_vector(11 downto 0)
	);
end id_reg;

architecture working of id_reg is
signal id_store: std_logic_vector(15 downto 0);
begin
	read_proc: process(opcode3, id_store)
	begin 
		if(opcode3="0001" or opcode3 = "0010") then
			reg_a1<=id_store(11 downto 9);
			reg_a2<=id_store(8 downto 6);
			reg_a3<=id_store(5 downto 3);
		elsif(opcode3="0000" or opcode3="0111") then
			reg_a1<=id_store(11 downto 9);
			reg_a3<=id_store(8 downto 6);
			imm<=id_store(5 downto 0);
		elsif(opcode3="0011")then
			reg_rd(11 downto 0)<=id_store(11 downto 0);
			
		end if;
	end process;
	
	
	write_proc: process(clk)
	begin 
		if(falling_edge(clk)) then
			id_store<= id;
		end if;
	end process;
end working;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity rd_reg is 
	port(
		reg : in std_logic_vector(34 downto 0);
		ex_reg : out std_logic_vector(2 downto 0);
		alu_a: out std_logic_vector(15 downto 0);
		alu_b: out std_logic_vector(15 downto 0);
		opcode3: in std_logic_vector(3 downto 0);
		opcode4: in std_logic_vector(3 downto  0);
		clk: in std_logic;
		id: in std_logic_vector(11 downto 0);
		exec_j: out std_logic_vector(18 downto 0)
	);
end rd_reg;

architecture working of rd_reg is
signal rd_store: std_logic_vector(34 downto 0);
begin
	read_proc: process(opcode4, rd_store )
	begin
		if(opcode4="0001" or opcode4 = "0010") then
			alu_a<= rd_store(15 downto 0);
			alu_b<=rd_store(31 downto 16);
			ex_reg<=rd_store(34 downto 32);
		elsif(opcode4="0000") then
			alu_a<= rd_store(15 downto 0);
			alu_b(5 downto 0)<=rd_store(21 downto 16);
			alu_b(15 downto 6)<="0000000000";
			ex_reg<=rd_store(34 downto 32);
		elsif(opcode4="0111") then
			alu_a<= rd_store(15 downto 0);
			alu_b(5 downto 0)<=rd_store(21 downto 16);
			alu_b(15 downto 6)<="0000000000";
			ex_reg<=rd_store(34 downto 32);
		elsif(opcode4="0011") then
			exec_j<=rd_store(18 downto 0);
		end if;
	end process;
	write_proc: process(clk)
	begin 
		if(falling_edge(clk)) then
			if (opcode3="0001" or opcode3="0000" or opcode3="0010" or opcode3="0111") then
				rd_store<= reg;
			elsif (opcode3="0011") then
				rd_store(11 downto 0)<=id;
			end if;
		end if;
	end process;
end working;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity execute_reg is 
	port(
		alu : in std_logic_vector(15 downto 0);
		rd_reg: in std_logic_vector(2 downto 0);
		opcode4: in std_logic_vector(3 downto 0);
		opcode5: in std_logic_vector(3 downto  0);
		mem_reg: out std_logic_vector(18 downto 0);
		mem_a:out std_logic_vector(15 downto 0);
		clk: in std_logic;
		no_write_in: in std_logic;
			no_write_out: out std_logic;
			rd_j: in std_logic_vector(18 downto 0)
	);
end execute_reg;

architecture working of execute_reg is
signal exe_store: std_logic_vector(18 downto 0);
signal no_write: std_logic;
begin
	no_write_out<=no_write;
	read_proc: process(opcode5, exe_store )
	begin
		if (opcode5="0001" or opcode5="0000" or opcode5="0011" or opcode5="0010") then
		  mem_reg <= exe_store;
		elsif(opcode5="0111") then
			mem_a<=exe_store(15 downto 0);
			mem_reg(2 downto 0)<=exe_store(18 downto 16);
		
		end if;
	end process;
	write_proc: process(clk)
	begin 
		if(falling_edge(clk)) then
			if (opcode4="0001" or opcode4="0000" or opcode4="0010" or opcode4="0111") then
				exe_store(15 downto 0)<= alu;
				exe_store(18 downto 16)<= rd_reg;
			elsif (opcode4="0011") then
				exe_store<=rd_j;
			end if;
			no_write<=no_write_in;
		end if;
	end process;
end working;

--Mem reg ka output is the input for the registers
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity memory_reg is 
	port(
		exec_reg: in std_logic_vector(18 downto 0);
		opcode5: in std_logic_vector(3 downto 0);
		opcode6: in std_logic_vector(3 downto 0);
		clk: in std_logic;
		wb_in: out std_logic_vector(18 downto 0);
		no_write_in: in std_logic;
			no_write_out: out std_logic;
			mem_data: in std_logic_vector(15 downto 0)
	);
end memory_reg;

architecture working of memory_reg is
signal mem_store: std_logic_vector(18 downto 0);
signal no_write:std_logic;
begin
	no_write_out<= no_write;
	read_proc: process(opcode6, mem_store )-- if the same load inst is used simultaneously a problem arises as 
	                                        -- sensitivity list not triggered. look into it 
	begin
		   if(opcode6="0001" or opcode5="0000" or opcode5="0011" or opcode6="0010" or opcode6="0111") then
				wb_in<= mem_store;
			end if;
	end process;
	
	write_proc: process(clk)
	begin 
		if(falling_edge(clk)) then
			no_write<=no_write_in;
			if (opcode5="0001" or opcode5="0000" or opcode5="0011" or opcode5="0010") then
				mem_store<= exec_reg;
				
			elsif (opcode5="0111") then
				mem_store(15 downto 0)<=mem_data;
				mem_store(18 downto 16)<=exec_reg(2 downto 0);
			end if;
		end if;
	end process;
end working;
