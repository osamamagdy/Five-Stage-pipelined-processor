LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
USE work.ALL;
ENTITY Fetch_Decode IS
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

        JumpAddress : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        Exception : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        Stack : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        HLT : IN STD_LOGIC;
        --
        MO_1 : IN STD_LOGIC_VECTOR(N - 1 DOWNTO 0);
        --
        ------------------------------------------
        OUT_PC : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        OUT_NEXT_PC : OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
        OUT_RS_DATA : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        OUT_SEC_OP : OUT STD_LOGIC_VECTOR (15 DOWNTO 0);
        OUT_RD_ADD : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_RS_ADD : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_RT_ADD : OUT STD_LOGIC_VECTOR (2 DOWNTO 0);
        OUT_EX_FLUSH : OUT STD_LOGIC;
        OUT_IF_FLUSH : OUT STD_LOGIC;
        HLT : OUT STD_LOGIC;

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
        RET : OUT STD_LOGIC);

    );
END Fetch_Decode;

ARCHITECTURE my_FD OF Fetch_Decode IS
    SIGNAL MUX1_SEL : STD_LOGIC_VECTOR(1 DOWNTO 0);
    SIGNAL pcOut : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL next_pcout : STD_LOGIC_VECTOR(31 DOWNTO 0);
    SIGNAL IR : STD_LOGIC_VECTOR(31 DOWNTO 0)
BEGIN

    myfetch : ENTITY work.fetch PORT MAP (

        );

    mydecode : ENTITY work.myDecode PORT MAP (

        OUT_PC       => OUT_PC        ,   
        OUT_NEXT_PC  => OUT_NEXT_PC   ,  
        OUT_RS_DATA  => OUT_RS_DATA   ,  
        OUT_SEC_OP   => OUT_SEC_OP    , 
        OUT_RD_ADD   => OUT_RD_ADD    , 
        OUT_RS_ADD   => OUT_RS_ADD    ,    
        OUT_RT_ADD   => OUT_RT_ADD    ,  
        OUT_EX_FLUSH => OUT_EX_FLUSH  ,   
        OUT_IF_FLUSH => OUT_IF_FLUSH  ,   
        HLT          => HLT           , 
        OUT_MUX_1    => MUX1_SEL      , 

        -------Outputfrom Control register
        MEM_VAL      => MEM_VAL       ,   
        MEM_ADD      => MEM_ADD       ,   
        SP_OP        => SP_OP         ,  
        SP_NUM       => SP_NUM        ,         
        WB           => WB            ,    
        MEM          => MEM           ,      
        EX           => EX            ,     
        RTI          => RTI           ,         
        BACKUP_FLAG  => BACKUP_FLAG   ,         
        RET          => RET                  
        );

END ARCHITECTURE;