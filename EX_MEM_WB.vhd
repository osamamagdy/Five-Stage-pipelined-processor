library IEEE;
use IEEE.std_logic_1164.all;
ENTITY EX_MEM_WB IS
    PORT (
        clk : IN STD_LOGIC;
        reset : IN STD_LOGIC;
        memValuein : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        memAddressin : IN STD_LOGIC;
        PCin : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        nextPCin : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        SPOPin : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        SPNUMin : IN STD_LOGIC;
        WBin : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        MEM : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        EX : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        RSdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        DATA_FOR_STORE : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        secondOperand : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        RTIin : IN STD_LOGIC;
        BackupFlag : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        rdAddressin : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        rsAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        rtAddress : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
        RETin : IN STD_LOGIC;
        EXflush : IN STD_LOGIC;
        flags : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);

        -- jump
        jumpAddress : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
        flush_mem_Wb : IN STD_LOGIC;
	-- from control unit
	out_port_en: IN STD_LOGIC;
        -- Outputs
        -- 
        -- output of mux 14
	rd_data: OUT std_logic_vector ( 31 downto 0);
	-- from alu result data
	output_port: OUT std_logic_vector ( 15 downto 0);

    RTI_OUTPUT : OUT std_LOGIC;
	RET_OUTPUT : OUT STD_LOGIC;
    Write_EN_OUT : OUT STD_LOGIC;
	RD_ADDRESS_OUTPUT : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
    -- exception handler pc
    Exception_Handler_out: out std_logic_vector(31 downto 0);
    -- is_exception OR NOT
    EXCEPTION_out: OUT STD_LOGIC;
    mux_10_sel: IN STD_LOGIC
    );
END EX_MEM_WB;

ARCHITECTURE arch OF EX_MEM_WB IS

    SIGNAL memValueout :  STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL memAddressout :  STD_LOGIC;
    SIGNAL nextPCout :  STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL WBout :  STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL MemRe :  STD_LOGIC;
    SIGNAL MemWr :  STD_LOGIC;
    SIGNAL SPOPout :  STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL SPNUMout :  STD_LOGIC;
    SIGNAL Rsrc1 :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL RTIout :  STD_LOGIC;
    SIGNAL RETout :  STD_LOGIC;
    SIGNAL PCout :  STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL rdAddressout :  STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL ALUres :  STD_LOGIC_VECTOR(15 DOWNTO 0);

    SIGNAL wb_en :  STD_LOGIC;
    SIGNAL alu_mem_output :  STD_LOGIC;
    SIGNAL alu_res_out :  STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL mem_out :  STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL signal_rti_output :  STD_LOGIC;
    SIGNAL signal_ret_output :  STD_LOGIC;
    SIGNAL signal_rd_address_output :  STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL out_port_en_exec_sig:  STD_LOGIC;
    SIGNAL out_port_en_mem_sig:  STD_LOGIC;
    SIGNAL wb_input: STD_LOGIC_VECTOR(54 DOWNTO 0);
    --SIGNAL FOR FORWARDING UNIT
    SIGNAL MUX_8_SEL : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL MUX_9_SEL : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL WB_EN_DUMMY : STD_LOGIC_VECTOR (1 DOWNTO 0);
    SIGNAL MEM_WB_RD_DATA : STD_LOGIC_VECTOR (31 DOWNTO 0);
SIGNAL abbas_sel:STD_LOGIC_VECTOR (1 DOWNTO 0);
    ----
BEGIN
	
WB_EN_DUMMY <= (wb_en & alu_mem_output);

EX_Stage : ENTITY work.ExecutionStage PORT MAP(
	clk, out_port_en,
	reset, memValuein, memAddressin, 
	PCin, nextPCin, SPOPin, 
	SPNUMin, WBin, MEM, EX, 
	RSdata, DATA_FOR_STORE ,secondOperand, RTIin, 
	BackupFlag, rdAddressin, rsAddress, 
	rtAddress, RETin, EXflush, 
    MEM_WB_RD_DATA(15 DOWNTO 0),
    ALUres,
    MUX_8_SEL,
    MUX_9_SEL,
    abbas_sel,
	memValueout, memAddressout, 
	nextPCout, WBout, MemRe, MemWr, 
	SPOPout, SPNUMout, Rsrc1, RTIout, RETout, 
	PCout, rdAddressout, ALUres, flags, jumpAddress,out_port_en_exec_sig
    );


myforwarding_unit : entity work.ForwardingUnit port map(
    current_op1_address => rsAddress  ,
    current_op2_address => rtAddress ,
    last_WB => WB_EN_DUMMY ,
    last_Rd => signal_rd_address_output ,
    before_last_WB =>  WBout ,
    before_last_Rd => rdAddressout ,
    op1_mux => MUX_8_SEL ,
    op2_mux =>  MUX_9_SEL,
    abbas =>  abbas_sel,
    mux_10_sel=>mux_10_sel
    );
    
MEM_Stage : ENTITY work.memory_stage PORT MAP(
        clk, out_port_en_exec_sig, flush_mem_Wb, reset, memValueout, 
	memAddressout, nextPCout, WBout, MemRe, 
	MemWr, SPOPout, SPNUMout, Rsrc1, ALUres, 
	RTIout, RETout, PCout, rdAddressout, "00",
        -- Outputs
	out_port_en_mem_sig,
        wb_en,
        alu_mem_output,
        alu_res_out,
        mem_out,
        signal_rti_output,
        signal_ret_output,
        signal_rd_address_output,
	Exception_Handler_out,
	EXCEPTION_out
    );
  	
wb_input(54)<=wb_en;
wb_input(53)<=alu_mem_output;
wb_input(52 downto 37)<=alu_res_out;
wb_input(36 downto 5)<=mem_out;
wb_input(4)<=signal_rti_output;
wb_input(3)<=signal_ret_output;
wb_input(2 downto 0)<=signal_rd_address_output;

WB_Stage : ENTITY work.write_back_stage PORT MAP(
	-- inputs
        clk,
	out_port_en_mem_sig,
	wb_input,
	-- output 
	MEM_WB_RD_DATA,
	output_port,
    RTI_OUTPUT ,
	RET_OUTPUT,
    Write_EN_OUT,
	RD_ADDRESS_OUTPUT 
    );

    rd_data <= MEM_WB_RD_DATA;

    

END ARCHITECTURE;