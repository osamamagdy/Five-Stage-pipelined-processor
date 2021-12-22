library IEEE;
use IEEE.std_logic_1164.all;

ENTITY write_back_stage IS
port(
	clk: IN STD_LOGIC;
	out_port_en: IN std_Logic;
	------ INPUTS Description------
	-- incication of enabling the wb
	-- INPUT[38]-> wb_en: IN std_logic;
	-- mux 14 selector
	--to choose whether to write back the alu result or the memory output
	-- INPUT[37]-> alu_mem: IN std_logic;
	-- input to mux 14: to be writed back
	-- input to output port
	-- INPUT[36: 21]-> alu_res: IN std_logic_vector(15 downto 0);
	-- memory output
	-- INPUT[20: 5]-> mem: IN std_logic_vector(15 downto 0);
	-- ret interrupt enable
	-- INPUT[4]-> rti: IN std_logic;
	-- ret from call enable
	-- INPUT[3]-> ret: in std_logic;
	-- rd address: the destination register, to enter the forwarding unit
	-- INPUT[2:0]-> rd_address_output: in std_logic_vector(2 downto 0);
	input: IN std_logic_vector( 38 downto 0 );
	-- output of mux 4
	rd_data: OUT std_logic_vector ( 15 downto 0);
	-- from alu result data
	output_port: OUT std_logic_vector ( 15 downto 0)
);

END write_back_stage;

ARCHITECTURE arch_write_back_stage OF write_back_stage IS
COMPONENT mux2x1 IS
GENERIC (n : integer := 8);
PORT( in0,in1: IN std_logic_vector (n-1 DOWNTO 0);
              sel : IN std_logic;
              out_mux: OUT std_logic_vector (n-1 DOWNTO 0));
END COMPONENT;

BEGIN
	output_port<= input(36 downto 21) when out_port_en = '1';
	-- connecting to the mem_wb buffer
	mux14: mux2x1 GENERIC MAP(16) PORT MAP(input(36 downto 21),input(20 downto 5), input(37), rd_data);

END arch_write_back_stage;