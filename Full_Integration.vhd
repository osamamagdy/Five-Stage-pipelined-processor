LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
ENTITY Processor IS
    PORT (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        IN_PORT : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        output_port : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END Processor;

ARCHITECTURE arch OF Processor IS
    COMPONENT EX_MEM_WB IS
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
            out_port_en : IN STD_LOGIC;
            -- Outputs
            -- 
            -- output of mux 4
            rd_data : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            -- from alu result data
            output_port : OUT STD_LOGIC_VECTOR (15 DOWNTO 0)
        );
    END COMPONENT;

    COMPONENT Fetch_Decode IS
        PORT (

            reset : IN STD_LOGIC;
            clk : IN STD_LOGIC;
            ----------------Decode inputs from outside -----------------
            IS_EXCEPTION, IN_RET, IN_RTI, IS_HAZARD : IN STD_LOGIC;

            IN_PORT : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

            Write_Address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);

            Write_Value : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

            Write_EN : IN STD_LOGIC;

            Flag_Reg : IN STD_LOGIC_VECTOR (2 DOWNTO 0);

            -------------------Fetch inputs from outside-----------------------------

            JumpAddress : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Exception : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            Stack : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

            MO_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            --
            ----------------- Out From Decode-------------------------
            OUT_PC : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
            OUT_NEXT_PC : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
            OUT_RS_DATA : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            OUT_SEC_OP : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
            OUT_RD_ADD : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            OUT_RS_ADD : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            OUT_RT_ADD : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
            OUT_EX_FLUSH : OUT STD_LOGIC;

            -------Outputs from Control register
            MEM_VAL : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            MEM_ADD : OUT STD_LOGIC;
            SP_OP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            SP_NUM : OUT STD_LOGIC;
            WB : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            MEM : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            EX : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
            RTI : OUT STD_LOGIC;
            BACKUP_FLAG : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
            RET : OUT STD_LOGIC

        );
    END COMPONENT;

    SIGNAL memValue : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL memAddress : STD_LOGIC;
    SIGNAL PC : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL nextPC : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL SPOP : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL SPNUM : STD_LOGIC;
    SIGNAL WB : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL MEM : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL EX : STD_LOGIC_VECTOR(3 DOWNTO 0);
    SIGNAL RSdata : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL secondOperand : STD_LOGIC_VECTOR(15 DOWNTO 0);
    SIGNAL RTI : STD_LOGIC;
    SIGNAL BackupFlag : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL rdAddress : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL rsAddress : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL rtAddress : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL RET : STD_LOGIC;
    SIGNAL EXflush : STD_LOGIC;
    SIGNAL flags : STD_LOGIC_VECTOR(2 DOWNTO 0);
    SIGNAL jumpAddress : STD_LOGIC_VECTOR(31 DOWNTO 0);
BEGIN
    EX_MEM_WB_Stages : EX_MEM_WB PORT MAP(
        clk,
        reset,
        memValue,
        memAddress,
        PC,
        nextPC,
        SPOP,
        SPNUM,
        WB,
        MEM,
        EX,
        RSdata,
        secondOperand,
        RTI,
        BackupFlag,
        rdAddress,
        rsAddress,
        rtAddress,
        RET,
        flags,
        jumpAddress,
        EXflush,

        -- Replace These with correct signals
        -- 
        -- 
        flush_mem_Wb : IN STD_LOGIC;
        -- from control unit
        out_port_en : IN STD_LOGIC;
        -- Outputs
        -- 
        -- output of mux 4
        rd_data : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        -- from alu result data
        output_port
    );
    Fetch_Decode_Stages : Fetch_Decode PORT MAP(

        reset,
        clk,
        ----------------Decode inputs from outside -----------------
        IS_EXCEPTION, IN_RET, IN_RTI, IS_HAZARD : IN STD_LOGIC;

        IN_PORT,

        Write_Address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);

        Write_Value : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

        Write_EN : IN STD_LOGIC;

        flags,

        -------------------Fetch inputs from outside-----------------------------

        jumpAddress,
        Exception : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Stack : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        MO_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        --
        ----------------- Out From Decode-------------------------
        PC,
        nextPC,
        RSdata,
        secondOperand,
        rdAddress,
        rsAddress,
        rtAddress,
        EXflush,

        -------Outputs from Control register
        memValue,
        memAddress,
        SPOP,
        SPNUM,
        WB,
        MEM,
        EX,
        RTI,
        BackupFlag,
        RET
    );
END ARCHITECTURE;