library IEEE;
use IEEE.std_logic_1164.all;

ENTITY write_back_stage IS
port(
	clk: IN STD_LOGIC;
	out_port_en: IN std_Logic;
	------ INPUTS Description------
	-- incication of enabling the wb
	-- INPUT[54]-> wb_en: IN std_logic;
	-- mux 14 selector
	-- to choose whether to write back the alu result or the memory output
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
	input: IN std_logic_vector( 54 downto 0 );
	-- output of mux 14
	rd_data: OUT std_logic_vector ( 31 downto 0);
	-- from alu result data
	output_port: OUT std_logic_vector ( 15 downto 0);
	--- Out put to the decode stage
	RTI_OUTPUT : OUT std_LOGIC;
	RET_OUTPUT : OUT STD_LOGIC;
	Write_EN_OUT : OUT STD_LOGIC;
	RD_ADDRESS_OUTPUT : OUT STD_LOGIC_VECTOR (2 DOWNTO 0)
);

END write_back_stage;

ARCHITECTURE arch_write_back_stage OF write_back_stage IS
COMPONENT mux2x1 IS
GENERIC (n : integer := 8);
PORT( in0,in1: IN std_logic_vector (n-1 DOWNTO 0);
              sel : IN std_logic;
              out_mux: OUT std_logic_vector (n-1 DOWNTO 0));
END COMPONENT;

COMPONENT sign_extend IS
	GENERIC ( n : integer := 32);
	PORT(
        input_16  : IN std_logic_vector( 15 downto 0);
        out_n : OUT std_logic_vector(n - 1 downto 0)
    );
END COMPONENT;
----------------------------------
SIGNAL alu_extended: STD_LOGIC_VECTOR(31 downto 0);
----------------------------------
BEGIN
	output_port<= input(52 downto 37) when out_port_en = '1';
	-- extending alu_res to fit the mux
	extend_alu: sign_extend GENERIC MAP(32) PORT MAP(input(52 downto 37),alu_extended);
	-- connecting to the mem_wb 
	mux14: mux2x1 GENERIC MAP(32) PORT MAP(alu_extended, input(36 downto 5), input(53), rd_data);
	-------
	RTI_OUTPUT <= INPUT(4);
	RET_OUTPUT <= INPUT(3);
	RD_ADDRESS_OUTPUT <= INPUT(2 DOWNTO 0);
	Write_EN_OUT <= INPUT(54);



END arch_write_back_stage;