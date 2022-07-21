library ieee;
use ieee.std_logic_1164.all;
entity DUT is
port ( input_vector : in std_logic_vector(0 downto 0);
			output_vector: out std_logic_vector(3 downto 0));
end entity;

architecture DutWrap of DUT is
	signal carry, zero: std_logic;
	
	component ir is 
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
	end component;
	
	component mem is 
	port(
		exe_out: in std_logic_vector(15 downto 0);
	 opcode5: in std_logic_vector(3 downto 0);
	 clk : in std_logic;
	 ins_addr: in std_logic_vector(15 downto 0);
	 ir_data: out std_logic_vector(15 downto 0);
	 mem_data: out std_logic_vector(15 downto 0)	
	 );
	end component;
	
	component registers is 
	port (reg_a1: in std_logic_vector(2 downto 0);
			reg_a2: in std_logic_vector(2 downto 0);
			reg_a3: in std_logic_vector(2 downto 0);
			reg_rd: out std_logic_vector(34 downto 0);
			opcode3: in std_logic_vector(3 downto 0);
			reg_wb: in std_logic_vector(18 downto 0);
			opcode6: in std_logic_vector(3 downto 0);
			imm: in std_logic_vector(5 downto 0);
			clk: in std_logic;
			no_write: in std_logic
	);
	end component;
	
	
	component sign_extender_7_component is
	port(ir_8_0: in std_logic_vector(8 downto 0);
	 alu: out std_logic_vector(15 downto 0);
	 state: in std_logic_vector(5 downto 0)
	 
	 );
	end component;
	
	
	component sign_extender_10_component is
	port(ir_5_0: in std_logic_vector(5 downto 0);
	 alu: out std_logic_vector(15 downto 0);
	 state: in std_logic_vector(5 downto 0)
	 );
	end component;
	
	component shifter_7 is 
	port (ir_8_0: in std_logic_vector(8 downto 0);
			rf_d3: out std_logic_vector(15 downto 0);
			state: in std_logic_vector(5 downto 0)
	);
	end component;
	
	
	component shifter_1 is 
	port (t2: in std_logic_vector(15 downto 0);
			alu_a: out std_logic_vector(15 downto 0);
			state: in std_logic_vector(5 downto 0)
	);
	end component;
	
	component pc is 
	port (if_reg: out std_logic_vector(15 downto 0);
			opcode: in std_logic_vector(3 downto 0);
			ins_mem: out std_logic_vector(15 downto 0);
			clk: in std_logic
	);
	end component;

component alu is
	port(opcode4: in std_logic_vector(3 downto 0);
	 alu_a: in std_logic_vector(15 downto 0);
	 alu_b: in std_logic_vector(15 downto 0);
	 ex_reg: out std_logic_vector(15 downto 0);
	 cz: in std_logic_vector(1 downto 0);
	 no_write: out std_logic
	 );
	 end component;
	 
component ins_dec is
	port (
		ins_dec_reg: in std_logic_vector(15 downto 0);
	clk: in std_logic	;
	op_code: in std_logic_vector(3 downto 0);
		id_reg: out std_logic_vector(15 downto 0)
			
	) ;
end component;


component if_reg is 
	port(
		ir : in std_logic_vector(15 downto 0);
		id : out std_logic_vector(15 downto 0);
		clk: in std_logic
	);
end component;

component id_reg is 
	port(
		id : in std_logic_vector(15 downto 0);
		reg_a1 : out std_logic_vector(2 downto 0);
		reg_a2 : out std_logic_vector(2 downto 0);
		imm: out std_logic_vector(5 downto 0);
		reg_a3 : out std_logic_vector(2 downto 0);
		opcode3: in std_logic_vector(3 downto 0);
		clk: in std_logic;
		reg_rd: out std_logic_vector(11 downto 0)
	);
end component;


component rd_reg is 
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
end component;

component execute_reg is 
	port(
		alu : in std_logic_vector(15 downto 0);
		rd_reg: in std_logic_vector(2 downto 0);
		opcode4: in std_logic_vector(3 downto 0);
		opcode5: in std_logic_vector(3 downto  0);
		mem_reg: out std_logic_vector(18 downto 0);
		clk: in std_logic;
		no_write_in: in std_logic;
			no_write_out: out std_logic;
			rd_j: in std_logic_vector(18 downto 0);
			mem_a:out std_logic_vector(15 downto 0)
	);
end component;

component memory_reg is 
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
end component;

signal w_ir_if, w_if_id, w_id_reg, w_rd_alua, w_rd_alub, w_ex_alu, curr_ins, w_pc_mem, w_exe_mem, w_data: std_logic_vector(15 downto 0);
signal w_reg_a1, w_reg_a2, w_reg_a3, w_rd_ex: std_logic_vector(2 downto 0);
signal w_wb, w_exec_mem,w_wb_mem, w_exec_j: std_logic_vector(18 downto 0);
signal w_rd_reg: std_logic_vector(34 downto 0);
signal opcode1, opcode2, opcode3, opcode4, opcode5, opcode6: std_logic_vector(3 downto 0);
signal cz: std_logic_vector(1 downto 0);
signal no_write, w_no_alu, w_no_mem, wb_no_write: std_logic;
signal w_imm: std_logic_vector(5 downto 0);
signal w_id_j:std_logic_vector(11 downto 0);


begin
		output_vector<=curr_ins(15 downto 12);
		ir_instance: ir
			port map(
			clk => input_vector(0),
			mem => curr_ins,
			id => w_ir_if,
			opcode1 => opcode1,
			opcode2 => opcode2,
			opcode3 => opcode3,
			opcode4 => opcode4,
			opcode5 => opcode5,
			opcode6 => opcode6,
			cz => cz
			);
			
		if_reg_instance: if_reg
		port map(
			ir  => w_ir_if,
			clk => input_vector(0),
			id => w_if_id
		);
		
		id_instance: ins_dec
		port map(
			clk => input_vector(0),
			ins_dec_reg => w_if_id,
			op_code => opcode2,
			id_reg => w_id_reg
		);
		
		id_reg_instance: id_reg
		port map(
			clk => input_vector(0),
			id => w_id_reg,
			opcode3 => opcode3,
			reg_a1 => w_reg_a1,
			reg_a2 => w_reg_a2,
			reg_a3 => w_reg_a3,
			imm => w_imm,
			reg_rd => w_id_j
		);
		
		reg_instance: registers
				port map(
					reg_a1 => w_reg_a1,
					reg_a2 => w_reg_a2,
					reg_a3 => w_reg_a3,
					reg_rd => w_rd_reg,
					opcode3 => opcode3,
					clk => input_vector(0),
					reg_wb => w_wb, 
					opcode6 => opcode6,
					no_write => wb_no_write,
					imm => w_imm
				);	
				
				
		rd_reg_instance: rd_reg
			port map(
				clk => input_vector(0),
				reg => w_rd_reg,
				ex_reg=> w_rd_ex,
				alu_a => w_rd_alua,
				alu_b => w_rd_alub,
				opcode3 => opcode3,
				opcode4 => opcode4,
				id => w_id_j,
				exec_j=> w_exec_j
				
			);
			
		execute_reg_instance: execute_reg
			port map(
		alu => w_ex_alu,
		rd_reg=> w_rd_ex,
		mem_reg=> w_exec_mem,
		opcode4 => opcode4,
		opcode5 => opcode5,
		clk => input_vector(0),
		no_write_in => w_no_alu,
		no_write_out => w_no_mem,
		rd_j=> w_exec_j,
		mem_a=> w_exe_mem
			);	
		
		alu_instance: alu
					port map(
						 opcode4=> opcode4,
						 alu_a=> w_rd_alua,
						 alu_b=> w_rd_alub,
						 ex_reg=> w_ex_alu,
						 cz => cz,
						 no_write=>w_no_alu
					);
					
			
		mem_instance: mem
			port map(
				clk => input_vector(0),
				opcode5=>opcode5,
				ins_addr=> w_pc_mem,
				ir_data=>curr_ins,
				exe_out=>w_exe_mem,
				mem_data=>w_data
				);
			
		mem_reg_instance: memory_reg
			port map (
			clk=> input_vector(0),
			opcode5 => opcode5,
			opcode6=> opcode6,
			exec_reg=>	w_exec_mem,
			wb_in => w_wb,
			no_write_in=> w_no_mem,
			no_write_out=> wb_no_write,
			mem_data=> w_data
			);	
				
			pc_instance: pc
					port map (
					opcode=> opcode1,
					clk=> input_vector(0),
					ins_mem=>w_pc_mem
					);
					
end DutWrap;