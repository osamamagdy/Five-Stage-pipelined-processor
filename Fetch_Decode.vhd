LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;
ENTITY Fetch_Decode IS
    PORT (

        reset : IN STD_LOGIC;
        clk   : IN STD_LOGIC;
        ----------------Decode inputs from outside -----------------
        IS_EXCEPTION, IN_RET, IN_RTI, IS_HAZARD : IN STD_LOGIC;

        IN_PORT : IN STD_LOGIC_VECTOR(15 DOWNTO 0);

        Write_Address : IN STD_LOGIC_VECTOR (2 DOWNTO 0);

        Write_Value : IN STD_LOGIC_VECTOR (15 DOWNTO 0);

        Write_EN : IN STD_LOGIC;

        Flag_Reg : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        IN_EX_BRANCH : IN STD_LOGIC_VECTOR (2 DOWNTO 0);
        IN_MEM_BRANCH : IN STD_LOGIC_VECTOR (1 DOWNTO 0);

        -------------------Fetch inputs from outside-----------------------------

        JumpAddress : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Exception   : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        Stack       : IN STD_LOGIC_VECTOR(31 DOWNTO 0);

        MO_1 : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        --
        ----------------- Out From Decode-------------------------
        OUT_PC       : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        OUT_NEXT_PC  : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        OUT_RS_DATA  : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        OUT_SEC_OP   : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        OUT_RD_ADD   : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_RS_ADD   : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_RT_ADD   : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_EX_FLUSH : OUT STD_LOGIC;
        OUT_DATA_FOR_STORE : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
        mux_10_sel   : OUT STD_LOGIC;


        OUT_DISABLE_FORWARDING : OUT STD_LOGIC;
        OUT_IS_STORE_OP : OUT STD_LOGIC;
        OUT_EX_BRANCH : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_MEM_BRANCH : OUT STD_LOGIC_VECTOR (1 DOWNTO 0);
    

        -------Outputs from Control register
        MEM_VAL     : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        MEM_ADD     : OUT STD_LOGIC;
        SP_OP       : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        SP_NUM      : OUT STD_LOGIC;
        WB          : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        MEM         : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        EX          : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
        RTI         : OUT STD_LOGIC;
        BACKUP_FLAG : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
        RET         : OUT STD_LOGIC ;
        OUT_PORT_EN : OUT STD_LOGIC

    );
END Fetch_Decode;

ARCHITECTURE my_FD OF Fetch_Decode IS

    -- FETCH SIGNALS FROM DECODE
    SIGNAL MUX1_SEL : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL HLT      : STD_LOGIC;

    -- FROM DECODE TO IF/ID BUFFER
    SIGNAL FLUSH : STD_LOGIC;

    -- FETCH STAGE  TO IF/ID BUFFER 
    SIGNAL BUFFER_pcOut, BUFFER_next_pcout, BUFFER_IR : STD_LOGIC_VECTOR(31 DOWNTO 0);

    -- SIGNAL FROM IF/ID BUFFER TO DECODE
    SIGNAL pcOut, next_pcout, IR : STD_LOGIC_VECTOR(31 DOWNTO 0);
    -- SIGNAL ENTERS 
BEGIN

    myfetch : ENTITY work.fetch PORT MAP (

        JumpAddress => JumpAddress,
        Exception   => Exception,
        Stack       => Stack,
        clk         => CLK,
        reset       => reset,
        MUX1_SEL    => MUX1_SEL,
        HLT         => HLT,
        MO_1        => MO_1,
        pcOut       => BUFFER_pcOut,
        next_pcout  => BUFFER_next_pcout,
        IR          => BUFFER_IR
        );

    IF_ID_BUFFER : ENTITY work.IFID_BUFFER PORT MAP (
        PC_IN       => BUFFER_pcOut,
        PC_NEXT_IN  => BUFFER_next_pcout,
        IR_IN       => BUFFER_IR,
        clk         => CLK,
        RST         => reset,
        FLUSH       => FLUSH,
        PC_OUT      => pcOut,
        PC_NEXT_OUT => next_pcout,
        IR_OUT      => IR
        );

    mydecode : ENTITY work.myDecode PORT MAP (
        -- IN PORTS
        CLK           => CLK,
        PC            => pcOut,
        Next_PC       => next_pcout,
        INSTRUCTION   => IR,
        IS_EXCEPTION  => IS_EXCEPTION,
        IN_RET        => IN_RET,
        IN_RTI        => IN_RTI,
        IS_HAZARD     => IS_HAZARD,
        IN_PORT       => IN_PORT,
        Write_Address => Write_Address,
        Write_Value   => Write_Value,
        Write_EN      => Write_EN,
        Flag_Reg      => Flag_Reg,
        IN_EX_BRANCH => IN_EX_BRANCH,
        IN_MEM_BRANCH => IN_MEM_BRANCH ,


        OUT_PC       => OUT_PC,
        OUT_NEXT_PC  => OUT_NEXT_PC,
        OUT_RS_DATA  => OUT_RS_DATA,
        OUT_SEC_OP   => OUT_SEC_OP,
        OUT_RD_ADD   => OUT_RD_ADD,
        OUT_RS_ADD   => OUT_RS_ADD,
        OUT_RT_ADD   => OUT_RT_ADD,
        OUT_EX_FLUSH => OUT_EX_FLUSH,
        OUT_IF_FLUSH => FLUSH,
        HLT          => HLT,
        OUT_MUX_1    => MUX1_SEL,
        mux_10_sel => mux_10_sel,
        OUT_DATA_FOR_STORE => OUT_DATA_FOR_STORE,

        -------Outputfrom Control register
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
        OUT_PORT_EN => OUT_PORT_EN,
        OUT_DISABLE_FORWARDING   =>  OUT_DISABLE_FORWARDING ,
        OUT_IS_STORE_OP  =>   OUT_IS_STORE_OP ,
        OUT_EX_BRANCH  =>   OUT_EX_BRANCH ,
        OUT_MEM_BRANCH  =>   OUT_MEM_BRANCH
    );

END ARCHITECTURE;