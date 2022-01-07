library IEEE;
use IEEE.std_logic_1164.all;
USE ieee.numeric_std.ALL;
ENTITY memory_stage IS
port(
	------ inputs ------
	clk: in std_logic;
	-- to enable writing on output port
	out_port_en: IN std_Logic;
	-- for flushing the write back stage
	flush_mem_Wb: in std_logic;
	--for resetting the cache
	reset: in std_logic; 
	-- Mux 12 selector : to choose which data to input to the chache
	mem_value: in std_logic_vector(1 downto 0);
	-- Mux 13 selector : to choose between data memory and stack memory
	mem_address: in std_logic; 
	-- pc+1 (input to mux 12): to enter the stack memory whenever an interrupt or Call occurs
	next_pc: in std_logic_vector(31 downto 0);
	-- writeback(2 bits): first bit (1) to indicate if the wb is enabled or not, 
	-- second bit (0)(mux 14 selector) to choose whether to write back the alu result or the memory output
	wb: in std_logic_vector(1 downto 0);
	-- memory read enable
	mem_read: in std_logic;
	-- memory write enable
	mem_write: in std_logic;
	-- stack adder/sub input to choose to pop or push (add or sub)
	-- sp[1] -> mux 16, sp[0] -> alu/sun
	sp_op: in std_logic_vector(1 downto 0);
	-- Mux 11 selector : to choose to add/sub 2 or 1 to the sp
	sp_num: in std_logic;
	-- input to mux 12: to enter the memory
	r_src1: in std_logic_vector(15 downto 0);
	-- input to mux 12: to enter the memory
	alu_res: in std_logic_vector(15 downto 0);
	-- ret interrupt enable
	rti: in std_logic;
	-- ret from call enable
	ret: in std_logic;
	-- pc (input to exception pc): if an exception occurs, we save it to the epc
	pc: in std_logic_vector(31 downto 0);
	-- rd address: the destination register, to enter the forwarding unit
	rd_address: in std_logic_vector(2 downto 0);
	---------------------

	------ outputs ------
	-- to enable writing on output port
	out_port_en_out: OUT std_Logic;
	-- incication of enabling the wb
	wb_en: out std_logic;
	-- mux 14 selector
	--to choose whether to write back the alu result or the memory output
	alu_mem_output: out std_logic;
	-- input to mux 14: to be writed back
	-- input to output port
	alu_res_out: out std_logic_vector(15 downto 0);
	-- memory output
	mem: out std_logic_vector(31 downto 0);
	-- ret interrupt enable
	rti_output: out std_logic;
	-- ret from call enable
	ret_output: out std_logic;
	-- rd address: the destination register, to enter the forwarding unit
	rd_address_output: out std_logic_vector(2 downto 0);
	-- exception handler pc
	Exception_Handler: out std_logic_vector(31 downto 0);
	-- is_exception OR NOT
	EXCEPTION: OUT STD_LOGIC
);
END memory_stage;

ARCHITECTURE mem_arch of memory_stage IS
Component mem_wb_buffer IS

PORT (
	flush : IN STD_LOGIC;
	clk: IN STD_LOGIC;
	------ INPUTS Description------
	-- incication of enabling the wb
	-- INPUT[54]-> wb_en: IN std_logic;
	-- mux 14 selector
	--to choose whether to write back the alu result or the memory output
	-- INPUT[53]-> alu_mem: IN std_logic;
	-- input to mux 14: to be writed back
	-- input to output port
	-- INPUT[52: 37]-> alu_res: IN std_logic_vector(15 downto 0);
	-- memory output
	-- INPUT[36: 5]-> mem: IN std_logic_vector(31 downto 0);
	-- ret interrupt enable
	-- INPUT[4]-> rti: IN std_logic;
	-- ret from call enable
	-- INPUT[3]-> ret: in std_logic;
	-- rd address: the destination register, to enter the forwarding unit
	-- INPUT[2:0]-> rd_address_output: in std_logic_vector(2 downto 0);
	input: IN std_logic_vector( 55 downto 0 );
    output : OUT std_logic_vector( 55 downto 0 ));
END Component;

Component memStageRam IS
	PORT(
		clk : IN std_logic;
		we  : IN std_logic; -- write enable (store)
        	re  : IN std_logic; -- read enable (load)
		sp_num: IN std_logic; -- if 0 then add 1, if 1 then add 2
		mem_Address: In std_logic; -- if 0: data, if 1: stack
		is_exception: In std_logic;
		address : IN  std_logic_vector(31 DOWNTO 0); 
		datain  : IN  std_logic_vector(31 DOWNTO 0); -- databus width
		dataout : OUT std_logic_vector(31 DOWNTO 0)); 
END Component;

Component mux4x1 IS
GENERIC (n : integer := 8);
PORT( in0,in1,in2,in3: IN std_logic_vector (n-1 DOWNTO 0);
              sel : IN std_logic_vector (1 DOWNTO 0);
              out1: OUT std_logic_vector (n-1 DOWNTO 0));
END Component;

Component mux2x1 IS
GENERIC (n : integer := 8);
PORT( in0,in1: IN std_logic_vector (n-1 DOWNTO 0);
              sel : IN std_logic;
              out_mux: OUT std_logic_vector (n-1 DOWNTO 0));
END Component;

Component sign_extend IS
	GENERIC ( n : integer := 32);
	PORT(
        input_16  : IN std_logic_vector( 15 downto 0);
        out_n : OUT std_logic_vector(n - 1 downto 0)
    );
END Component;

Component epc IS
	GENERIC ( n : integer := 32);
	PORT( 
		clk, en, rst : IN std_logic;
		d : IN std_logic_vector(n-1 DOWNTO 0);
		q : OUT std_logic_vector(n-1 DOWNTO 0));
END Component;
Component SP_REGISTER IS
    GENERIC (N : INTEGER := 32);
    PORT (
        D: IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
        CLK, RST: IN STD_LOGIC;
        Q: OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0)
    );
END Component;

Component ExceptionUnit IS
	PORT(
		
		mem_Address: In std_logic; -- if 0: data, if 1: stack
        stack_op: In std_logic; -- sp_op[0]: if 0: push if 1: pop
		stack_address : IN  std_logic_vector(31 DOWNTO 0); 
        memory_address : IN  std_logic_vector(15 DOWNTO 0); -- coming from alu result
		is_exception: OUT std_logic
		);
END Component;


---- Signals ----
SIGNAL q: std_logic_vector(55 downto 0); -- buffer input
SIGNAL d: std_logic_vector(55 downto 0); -- buffer output
SIGNAL alu_extended: std_logic_vector(31 downto 0); --alu result
SIGNAL r_src1_extended: std_logic_vector(31 downto 0); 
SIGNAL memory_datain: std_logic_vector(31 downto 0); 
SIGNAL memory_address_in:  std_logic_vector(31 downto 0); 
SIGNAL stack_address_in: std_logic_vector(31 downto 0); 

SIGNAL stack_address: std_logic_vector(31 downto 0); 
SIGNAL increment_amount: std_logic_vector(31 downto 0); 
SIGNAL new_sp: std_logic_vector(31 downto 0); 
SIGNAL final_sp:  std_logic_vector(31 downto 0); 
SIGNAL IS_EX: std_logic;
SIGNAL EPC_out: std_logic_vector(31 downto 0); 
SIGNAL mem_out: std_logic_vector(31 downto 0); 
BEGIN
	-- writing to the mem/wb buffer
	q(55)<=out_port_en;
	q(54 downto 53)<= wb;
	q(52 downto 37)<= alu_res;
	q(36 downto 5)<= mem_out;
	q(4)<= rti; 
	q(3)<= ret;
	q(2 downto 0)<= rd_address;
	-- getting output of the mem/wb buffer
	out_port_en_out<=d(55);
	wb_en<= d(54);
	alu_mem_output<= d(53);
	alu_res_out<= d(52 downto 37);
	mem<= d(36 downto 5);
	rti_output <= d(4);
	ret_output <= d(3);
	rd_address_output <= d(2 downto 0);
	-- extending data to fit muxes
	extend_alu_result: sign_extend GENERIC MAP(32) PORT MAP(alu_res, alu_extended);
	extend_r_src1: sign_extend GENERIC MAP(32) PORT MAP(r_src1,r_src1_extended);

	-- choosing the memory data-in
	mux12: mux4x1 GENERIC MAP(32) PORT MAP(r_src1_extended, alu_extended,next_pc,next_pc,mem_value, memory_datain);
	mux13: mux2x1 GENERIC MAP(32) PORT MAP(pc, stack_address,mem_address, memory_address_in); 
	-- stack pointer
	mux11: mux2x1 GENERIC MAP(32) PORT MAP(X"00000001", X"00000002",sp_num, increment_amount); 
	mux16: mux2x1 GENERIC MAP(32) PORT MAP(stack_address, new_sp,sp_op(1), stack_address_in); 
	mux17: mux2x1 GENERIC MAP(32) PORT MAP(stack_address, new_sp, sp_op(0), final_sp); 
	sp_register_call: SP_REGISTER GENERIC Map(32) PORT MAP(
        stack_address_in,
        clk, '0', -- i don't know if we'll need to reset it or not
        stack_address
    );

	-- adder/sub
	new_sp <= std_logic_vector(unsigned(stack_address) + unsigned(increment_amount)) when sp_op(0) ='1' 
	ELSE std_logic_vector(unsigned(stack_address) - unsigned(increment_amount)) when sp_op(0) ='0' ;

	-- connecting to the mem_wb buffer
	mem_wb_buff: mem_wb_buffer PORT MAP(flush_mem_Wb,clk,q, d);

	-- Exception Unit
	ExceptionUnitCall: ExceptionUnit 
	PORT MAP(
		mem_address,
        sp_op(0),
		final_sp,
        alu_res,
		IS_EX
		);
	ExceptionPC: epc GENERIC MAP(32) PORT MAP(clk, IS_EX, '0', pc, EPC_out);
	-----------------
	--- ram
	DataMemAndStack: memStageRam PORT MAP(
		clk,
		mem_write,
        mem_read,
		sp_num, -- if 0 then add 1, if 1 then add 2(as a push/pop indicator)
		mem_address, -- if 0: data, if 1: stack
		IS_EX,
		memory_address_in,
		memory_datain,
		mem_out); 
	mem<=	mem_out;
	Exception_Handler<=	mem_out when IS_EX='1';
	EXCEPTION<= IS_EX;
END mem_arch;

