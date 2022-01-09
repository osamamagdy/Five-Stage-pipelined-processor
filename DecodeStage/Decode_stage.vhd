LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;
----------------------------------------------------------------------------------------------------
---------------------------------4x1 MUX---------------------------------------------------------------------
ENTITY mux4 IS
    PORT (
        in0, in1, in2, in3 : IN STD_LOGIC_VECTOR (15 DOWNTO 0);
        sel                : IN STD_LOGIC_VECTOR (1 DOWNTO 0);
        out1               : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END ENTITY;
---------------------------------------------------------
ARCHITECTURE model_mux4 OF mux4 IS
BEGIN
    WITH sel SELECT
        out1 <=
        in0 WHEN "00",
        in1 WHEN "01",
        in2 WHEN "10",
        in3 WHEN OTHERS;
END ARCHITECTURE;
----------------------------------------------------------------------------------------------------
---------------------------------2x1 MUX---------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;
ENTITY mux2 IS
    GENERIC (n : INTEGER := 16);
    PORT (
        in0, in1 : IN STD_LOGIC_VECTOR (n - 1 DOWNTO 0);
        sel      : IN STD_LOGIC;
        out1     : OUT STD_LOGIC_VECTOR (n - 1 DOWNTO 0));
END ENTITY;
---------------------------------------------------------
ARCHITECTURE model_mux2 OF mux2 IS
BEGIN
    WITH sel SELECT
        out1 <=
        in0 WHEN '0',
        in1 WHEN OTHERS;
END ARCHITECTURE;

-------------------------------------------------------------------------------------------------------------
----------------------------------------------Whole Decode Stage---------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE work.ALL;
ENTITY myDecode IS
    PORT (

        CLK                      : IN STD_LOGIC;
        PC, Next_PC, INSTRUCTION : IN STD_LOGIC_VECTOR (31 DOWNTO 0);

        IS_EXCEPTION, IN_RET, IN_RTI, IS_HAZARD : IN STD_LOGIC;

        IN_PORT : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

        Write_Address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);

        Write_Value : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

        Write_EN : IN STD_LOGIC;

        Flag_Reg : IN STD_LOGIC_VECTOR (2 DOWNTO 0);

        -------Outputs
        OUT_PC       : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        OUT_NEXT_PC  : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        OUT_RS_DATA  : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        OUT_SEC_OP   : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        OUT_RD_ADD   : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_RS_ADD   : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_RT_ADD   : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_EX_FLUSH : OUT STD_LOGIC;
        OUT_IF_FLUSH : OUT STD_LOGIC;
        HLT          : OUT STD_LOGIC;
        OUT_MUX_1    : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        mux_10_sel   : OUT STD_LOGIC;

        -------Outputs from Control register
        MEM_VAL            : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        MEM_ADD            : OUT STD_LOGIC;
        SP_OP              : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        SP_NUM             : OUT STD_LOGIC;
        WB                 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        MEM                : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        EX                 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        RTI                : OUT STD_LOGIC;
        BACKUP_FLAG        : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        RET                : OUT STD_LOGIC;
        OUT_PORT_EN        : OUT STD_LOGIC;
        OUT_DATA_FOR_STORE : OUT STD_LOGIC_VECTOR(15 DOWNTO 0));

END ENTITY;
---------------------------------------------------------
ARCHITECTURE my_Decode OF myDecode IS

    SIGNAL reg_file_out1   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL reg_file_out2   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL reg_file_out3   : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL mux_5_selector  : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL mux_4_selector  : STD_LOGIC;
    SIGNAL mux_10_selector : STD_LOGIC;
    SIGNAL OR_gate_out     : STD_LOGIC;
    SIGNAL OR_gate_in      : STD_LOGIC;
    SIGNAL CONTROL_SIGNALS : STD_LOGIC_VECTOR(18 DOWNTO 0);
    SIGNAL Buffer_Input    : STD_LOGIC_VECTOR(18 DOWNTO 0);
    SIGNAL second_operand  : STD_LOGIC_VECTOR (15 DOWNTO 0);
    SIGNAL RS_DATA         : STD_LOGIC_VECTOR (15 DOWNTO 0);
BEGIN
    myReg_file : ENTITY work.reg_file PORT MAP(
        CLK             => CLK,
        address_read_1  => INSTRUCTION(26 DOWNTO 24),
        address_read_2  => INSTRUCTION(23 DOWNTO 21),
        address_read_3  => INSTRUCTION(20 DOWNTO 18),
        address_write   => Write_Address,
        en_write        => Write_EN,
        write_data_bus  => Write_Value,
        read_1_data_bus => reg_file_out1,
        read_2_data_bus => reg_file_out2,
        read_3_data_bus => reg_file_out3
        );
    myCU : ENTITY work.CU PORT MAP(
        RET             => IN_RET,
        IS_EXCEPTION    => IS_EXCEPTION,
        RTI             => IN_RTI,
        Flag_reg        => Flag_Reg,
        OP_CODE         => INSTRUCTION(31 DOWNTO 27),
        EX_Flush        => OUT_EX_FLUSH,
        ID_Flush        => OR_gate_in,
        MUX_10          => mux_10_selector,
        IF_Flush        => OUT_IF_FLUSH,
        HLT             => HLT,
        MUX_5           => mux_5_selector,
        MUX_1           => OUT_MUX_1,
        Control_Signals => CONTROL_SIGNALS
        );

    OR_gate_out <= (OR_gate_in OR IS_HAZARD);

    myMux4 : ENTITY work.mux2 GENERIC MAP (19) PORT MAP(
        sel  => OR_gate_out,
        in0  => CONTROL_SIGNALS,
        in1 => (OTHERS => '0'),
        out1 => Buffer_Input
        );
    mux_10_sel <= mux_10_selector;
    myMux10 : ENTITY work.mux2 GENERIC MAP (16) PORT MAP(
        sel  => mux_10_selector,
        in0  => reg_file_out3,
        in1  => INSTRUCTION(15 DOWNTO 0),
        out1 => second_operand
        );

    myMux5 : ENTITY work.mux4 PORT MAP(
        in0  => IN_PORT,
        in1  => reg_file_out1,
        in2  => reg_file_out2,
        in3  => reg_file_out3,
        sel  => mux_5_selector,
        out1 => RS_DATA

        );
    myBuffer : ENTITY work.ID_Buffer PORT MAP (

        Clk => Clk,
        rst => OR_gate_out,

        --------Inputs
        Control_Signal    => CONTROL_SIGNALS,
        IN_PC             => PC,
        IN_NEXT_PC        => Next_PC,
        IN_RS_DATA        => RS_DATA,
        IN_SEC_OP         => second_operand,
        IN_RD_ADD         => INSTRUCTION(26 DOWNTO 24),
        IN_RS_ADD         => INSTRUCTION(23 DOWNTO 21),
        IN_RT_ADD         => INSTRUCTION(20 DOWNTO 18),
        IN_DATA_FOR_STORE => reg_file_out1,

        -------Outputs
        OUT_PC             => OUT_PC,
        OUT_NEXT_PC        => OUT_NEXT_PC,
        OUT_RS_DATA        => OUT_RS_DATA,
        OUT_SEC_OP         => OUT_SEC_OP,
        OUT_RD_ADD         => OUT_RD_ADD,
        OUT_RS_ADD         => OUT_RS_ADD,
        OUT_RT_ADD         => OUT_RT_ADD,
        OUT_DATA_FOR_STORE => OUT_DATA_FOR_STORE,

        -------Outputs from Control register
        MEM_VAL     => MEM_VAL,
        MEM_ADD     => MEM_ADD,
        SP_OP       => SP_OP,
        SP_NUM      => SP_NUM,
        WB          => WB,
        MEM         => MEM,
        EX          => EX,
        RTI         => RTI,
        BACKUP_FLAG => BACKUP_FLAG,
        RET         => RET,
        OUT_PORT_EN => OUT_PORT_EN

        );
END ARCHITECTURE;