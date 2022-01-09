LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE work.ALL;

ENTITY Processor IS
    PORT (
        reset : IN STD_LOGIC;
        clk : IN STD_LOGIC;
        IN_PORT : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
        output_port : OUT STD_LOGIC_VECTOR (15 DOWNTO 0));
END Processor;

ARCHITECTURE arch OF Processor IS

        ----------------- Out From Decode-------------------------
        SIGNAL OUT_PC       : STD_LOGIC_VECTOR (31 DOWNTO 0);
        SIGNAL OUT_NEXT_PC  : STD_LOGIC_VECTOR (31 DOWNTO 0);
        SIGNAL OUT_RS_DATA  : STD_LOGIC_VECTOR (15 DOWNTO 0);
        SIGNAL OUT_SEC_OP   : STD_LOGIC_VECTOR (15 DOWNTO 0);
        SIGNAL OUT_RD_ADD   : STD_LOGIC_VECTOR (2 DOWNTO 0);
        SIGNAL OUT_RS_ADD   : STD_LOGIC_VECTOR (2 DOWNTO 0);
        SIGNAL OUT_RT_ADD   : STD_LOGIC_VECTOR (2 DOWNTO 0);
        SIGNAL OUT_EX_FLUSH : STD_LOGIC;
        SIGNAL OUT_DATA_FOR_STORE : STD_LOGIC_VECTOR (15 DOWNTO 0);

        -------Outputs from Control register-------------------
        SIGNAL MEM_VAL     : STD_LOGIC_VECTOR(1 DOWNTO 0);
        SIGNAL MEM_ADD     : STD_LOGIC;
        SIGNAL SP_OP       : STD_LOGIC_VECTOR(1 DOWNTO 0);
        SIGNAL SP_NUM      : STD_LOGIC;
        SIGNAL WB          : STD_LOGIC_VECTOR(1 DOWNTO 0);
        SIGNAL MEM         : STD_LOGIC_VECTOR(1 DOWNTO 0);
        SIGNAL EX          : STD_LOGIC_VECTOR(3 DOWNTO 0);
        SIGNAL RTI         : STD_LOGIC;
        SIGNAL BACKUP_FLAG : STD_LOGIC_VECTOR(1 DOWNTO 0);
        SIGNAL RET         : STD_LOGIC ;
        SIGNAL OUT_PORT_EN : STD_LOGIC ;
        SIGNAL mux_10_sel   : STD_LOGIC;

        -------Outputs From EX_MEM_WB Stage---------------------
        SIGNAL flags : STD_LOGIC_VECTOR(2 DOWNTO 0);
        SIGNAL jumpAddress : STD_LOGIC_VECTOR(31 DOWNTO 0);
        SIGNAL RTI_OUTPUT : std_LOGIC;
        SIGNAL RET_OUTPUT : STD_LOGIC;
        SIGNAL Write_EN_OUT : STD_LOGIC;
        SIGNAL RD_ADDRESS_OUTPUT : STD_LOGIC_VECTOR (2 DOWNTO 0);
        -- output of mux 4
        SIGNAL rd_data: std_logic_vector ( 31 downto 0);
        -- from alu result data
        SIGNAL Exception_Handler_out: std_logic_vector ( 31 downto 0);
        SIGNAL EXCEPTION_out: std_logic;
    
    

BEGIN
    EX_MEM_WB_Stages : ENTITY work.EX_MEM_WB PORT MAP(
        clk => clk,
        reset => reset,
        memValuein => MEM_VAL,
        memAddressin => MEM_ADD ,
        PCin => OUT_PC,
        nextPCin => OUT_NEXT_PC ,
        SPOPin => SP_OP,
        SPNUMin => SP_NUM,
        WBin => WB ,
        MEM => MEM ,
        EX => EX ,
        RSdata => OUT_RS_DATA ,
        DATA_FOR_STORE => OUT_DATA_FOR_STORE,
        secondOperand => OUT_SEC_OP ,
        RTIin => RTI ,
        BackupFlag => BACKUP_FLAG ,
        rdAddressin => OUT_RD_ADD ,
        rsAddress => OUT_RS_ADD ,
        rtAddress => OUT_RT_ADD ,
        RETin => RET ,
        EXflush => OUT_EX_FLUSH ,
        flags => flags ,     --OUT
        jumpAddress => jumpAddress ,    --OUT

        -- Replace These with correct signals
        -- 
        -- 
        flush_mem_Wb => '0' , --As there is no case to flush the Write back buffer (exceptions happen in the Execute stage not after)
        -- from control unit
        out_port_en => OUT_PORT_EN, --Input
        -- Outputs
        RTI_OUTPUT => RTI_OUTPUT ,
        RET_OUTPUT => RET_OUTPUT ,
        Write_EN_OUT => Write_EN_OUT,
        RD_ADDRESS_OUTPUT => RD_ADDRESS_OUTPUT,
        -- output of mux 4
        rd_data => rd_data,
        -- from alu result data
        output_port => output_port,
        Exception_Handler_out => Exception_Handler_out,
        EXCEPTION_out => EXCEPTION_out,
        mux_10_sel=>mux_10_sel

    );

    Fetch_Decode_Stages : ENTITY work.Fetch_Decode PORT MAP(


        reset => reset,
        clk   => clk ,
        ----------------Decode inputs from outside -----------------
        
        IS_EXCEPTION => '0' ,   -----------?????????????????From Exception Unit when implemented 
        
        IN_RET => RTI_OUTPUT ,       

        IN_RTI => RTI_OUTPUT ,        

        IS_HAZARD => '0' ,      ---------------???????????? Came From Hazard Detection Unit

        IN_PORT => IN_PORT ,

        Write_Address => RD_ADDRESS_OUTPUT , --------------??????????? NOT implemented yet

        Write_Value =>   rd_data(15 DOWNTO 0) ,

        Write_EN =>  Write_EN_OUT ,      

        Flag_Reg =>  flags,

        -------------------Fetch inputs from outside-----------------------------

        JumpAddress => jumpAddress ,
        Exception   => (OTHERS => '0' ),        -------????????????NOT yet implemented, came from Exception unit
        Stack       => (OTHERS => '0' ),        -------????????????NOT yet implemented, came from Memory

        MO_1 => (OTHERS => '0' ),               ------?????????????????NOT Used
        --
        ----------------- Out From Decode-------------------------
        OUT_PC       => OUT_PC       ,
        OUT_NEXT_PC  => OUT_NEXT_PC   ,
        OUT_RS_DATA  => OUT_RS_DATA   ,
        OUT_SEC_OP   => OUT_SEC_OP    ,
        OUT_RD_ADD   => OUT_RD_ADD    ,
        OUT_RS_ADD   => OUT_RS_ADD    ,
        OUT_RT_ADD   => OUT_RT_ADD    ,
        OUT_EX_FLUSH => OUT_EX_FLUSH  ,
        mux_10_sel => mux_10_sel,
        OUT_DATA_FOR_STORE => OUT_DATA_FOR_STORE,

        -------Outputs from Control register
        MEM_VAL      => MEM_VAL       ,
        MEM_ADD      => MEM_ADD      ,
        SP_OP        => SP_OP        ,
        SP_NUM       => SP_NUM       ,
        WB           => WB           ,
        MEM          => MEM          ,
        EX           => EX           ,
        RTI          => RTI          ,
        BACKUP_FLAG  => BACKUP_FLAG  ,
        RET          => RET           ,
        OUT_PORT_EN  => OUT_PORT_EN

    );
END ARCHITECTURE;